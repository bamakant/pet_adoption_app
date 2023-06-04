import 'package:flutter/material.dart';
import 'package:pet_adoption_app/feature/history/notifier/history_notifier.dart';
import 'package:pet_adoption_app/feature/home/widgets/pet_widget.dart';
import 'package:pet_adoption_app/utils/utils.dart';
import 'package:provider/provider.dart';

class History extends StatefulWidget {
  final Map<String, dynamic> alreadyAdoptedPets;

  const History({Key? key, required this.alreadyAdoptedPets}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late HistoryNotifier _notifier;
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _notifier = HistoryNotifier(context, widget.alreadyAdoptedPets);
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
        appBar: _appBar(),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'My Adopted Pets',
                  textScaleFactor: 3,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _petListWidget(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: Consumer<HistoryNotifier>(
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

  Widget _petListWidget() {
    return Consumer<HistoryNotifier>(
      builder: (context, value, child) => _notifier.petsList.isNotEmpty
          ? Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => PetWidget(
                  pet: _notifier.petsList[index],
                  isAlreadyAdopted: true,
                ),
                itemCount: _notifier.petsList.length,
              ),
            )
          : const Center(
              child: Text('No pets adopted.'),
            ),
    );
  }
}
