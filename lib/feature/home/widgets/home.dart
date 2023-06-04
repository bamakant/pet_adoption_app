import 'package:flutter/material.dart';
import 'package:pet_adoption_app/feature/home/notifier/home_notifier.dart';
import 'package:pet_adoption_app/feature/home/widgets/pet_widget.dart';
import 'package:pet_adoption_app/utils/utils.dart';
import 'package:pet_adoption_app/utils/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late HomeNotifier _notifier;
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _notifier = HomeNotifier(context);
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
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              _appBar(),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Search For A Pet',
                  textScaleFactor: 3,
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black),
                ),
              ),
              _searchFieldWidget(),
              _petListWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchFieldWidget() {
    return Consumer<HomeNotifier>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomTextField(
            hint: 'Search',
            controller: _notifier.searchTextController,
            onChange: _notifier.onSearchTextChange,
            focusNode: _notifier.searchTextFocusNode),
      ),
    );
  }

  Widget _petListWidget() {
    return Consumer<HomeNotifier>(
      builder: (context, value, child) => _notifier.petsList.isNotEmpty
          ? Expanded(
              child: ListView.builder(
                key: const Key('petList'),
                itemBuilder: (context, index) => PetWidget(
                  pet: _notifier.petsList[index],
                  onTap: () => _notifier.onTapCard(index),
                  isAlreadyAdopted: !_notifier.alreadyAdoptedPets
                      .containsKey(_notifier.petsList[index]['id']),
                ),
                itemCount: _notifier.petsList.length,
              ),
            )
          : const Center(
              child: Text('No pets found.'),
            ),
    );
  }

  Widget _appBar() {
    return Consumer<HomeNotifier>(
      builder: (context, value, child) => Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: _notifier.onHistoryIconTap,
          child: Container(
            margin: const EdgeInsets.only(right: 16.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDarkMode ? Colors.black : Colors.white,
            ),
            child: const Icon(
              Icons.bookmark,
              color: Colors.blue,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
