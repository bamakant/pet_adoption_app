import 'package:flutter/cupertino.dart';
import 'package:pet_adoption_app/utils/data.dart';

class HistoryNotifier extends ChangeNotifier {
  late BuildContext context;
  late List<dynamic> petsList;

  Map<String, dynamic> alreadyAdoptedPets = {};

  HistoryNotifier(this.context, this.alreadyAdoptedPets);

  Future<void> init() async {
    petsList = [];
    alreadyAdoptedPets.forEach((key, value) {
      petsList.addAll(pets.where((element) => element['id'] == key).toList());
    });
    notifyListeners();
  }

  void onBackPress() {
    Navigator.pop(context);
  }
}
