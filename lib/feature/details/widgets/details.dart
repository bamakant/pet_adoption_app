import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:pet_adoption_app/feature/details/notifier/details_notifier.dart';
import 'package:pet_adoption_app/utils/theme.dart';
import 'package:pet_adoption_app/utils/utils.dart';
import 'package:pet_adoption_app/utils/widgets/custom_widgets.dart';
import 'package:pet_adoption_app/utils/widgets/custom_image_viewer.dart';
import 'package:pet_adoption_app/utils/widgets/ratings_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class Details extends StatefulWidget {
  final pet;

  const Details(this.pet, {Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late DetailsNotifier _notifier;
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _notifier = DetailsNotifier(context, widget.pet);
    _notifier.init();
  }

  @override
  Widget build(BuildContext context) {
    isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    isDarkMode ? Utils.setDarkStatusBar() : Utils.setLightStatusBar();

    return ChangeNotifierProvider(
      create: (_) => _notifier,
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        extendBodyBehindAppBar: true,
        appBar: _appBar(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _petImageWithInfo(),
              const SizedBox(height: 16),
              _petAttributes(),
              _confettiWidget(),
              _petDescription(),
            ],
          ),
        ),
        bottomSheet: _adoptMeButton(),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: Consumer<DetailsNotifier>(
        builder: (context, value, child) => Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: _notifier.onBackPress,
            child: Container(
              margin: const EdgeInsets.only(left: 16.0, top: 8),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDarkMode ? Colors.black : Colors.white,
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: isDarkMode ? Colors.white : Colors.black,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _petImageWithInfo() {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 350,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40),
              bottom: Radius.zero,
            ),
          ),
          child: Hero(
            tag: widget.pet['id'],
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomImageViewer(
                        imageUrl: widget.pet["image"],
                        heroId: widget.pet['id']),
                  ),
                );
              },
              child: CachedNetworkImage(
                imageUrl: widget.pet["image"],
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.black26,
                  highlightColor: Colors.black12,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black54),
                    width: double.infinity,
                    height: 350,
                  ),
                ),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(40),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: GlassContainer(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            blur: 10,
            opacity: 0.15,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black87.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.pet["name"] ?? '',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      RatingWidget(
                        value: widget.pet["rate"].toInt(),
                      )
                    ],
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.pet["price"] ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _petAttributes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _boxAttributeContainer('Sex', widget.pet['sex']),
        _boxAttributeContainer('Color', widget.pet['color']),
        _boxAttributeContainer('Age', widget.pet['age']),
      ],
    );
  }

  Widget _adoptMeButton() {
    return Container(
      color: isDarkMode ? MyTheme.darkCreamColor : MyTheme.creamColor,
      child: Consumer<DetailsNotifier>(
        builder: (context, value, child) => Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomWidgets.filledButton(
                  text: 'Adopt Me',
                  onPressed: () => _notifier.onClickAdoptMe(widget.pet['name']),
                  isEnabled: _notifier.isAdoptAllowed,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boxAttributeContainer(String title, String value) {
    return Container(
      width: 100,
      height: 100,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.redAccent,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          )
        ],
      ),
    );
  }

  Widget _petDescription() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
      child: Text(
        widget.pet['description'],
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: isDarkMode ? Colors.white70 : Colors.black54,
        ),
      ),
    );
  }

  Widget _confettiWidget() {
    return Consumer<DetailsNotifier>(
      builder: (context, value, child) => Center(
        child: ConfettiWidget(
          confettiController: _notifier.confettiController,
          blastDirection: -pi / 2,
          gravity: 0.3,
          numberOfParticles: 20,
          emissionFrequency: 0.5,
        ),
      ),
    );
  }
}
