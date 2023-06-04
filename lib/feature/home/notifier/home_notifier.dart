import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pet_adoption_app/config/constants.dart';
import 'package:pet_adoption_app/feature/details/widgets/details.dart';
import 'package:pet_adoption_app/feature/history/widgets/history.dart';
import 'package:pet_adoption_app/utils/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeNotifier extends ChangeNotifier {
  late BuildContext context;

  TextEditingController searchTextController = TextEditingController();

  FocusNode searchTextFocusNode = FocusNode();

  late List<dynamic> petsList;

  late SharedPreferences sharedPreferences;

  Map<String, dynamic> alreadyAdoptedPets = {};

  HomeNotifier(this.context);

  Future<void> init() async {
    searchTextController.addListener(() {
      searchTextController.selection =
          TextSelection.collapsed(offset: searchTextController.text.length);
    });
    petsList = pets;
    sharedPreferences = await SharedPreferences.getInstance();
    String adoptedPetsAsString =
        sharedPreferences.getString(Constants.prefKeyAdoptedPets) ?? '{}';
    alreadyAdoptedPets = json.decode(adoptedPetsAsString);
    notifyListeners();
  }

  void onSearchTextChange(String? value) {
    searchTextController.text = value ?? '';
    if (value != null && value.isNotEmpty) {
      petsList = pets
          .where((element) => (element["name"].toLowerCase())
              .contains(searchTextController.text.toLowerCase()))
          .toList();
    } else {
      petsList = pets;
    }
    notifyListeners();
  }

  void onHistoryIconTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => History(alreadyAdoptedPets: alreadyAdoptedPets),
      ),
    );
  }

  Future<void> onTapCard(int index) async {
    searchTextFocusNode.unfocus();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Details(petsList[index]),
      ),
    );
    try {
      String adoptedPetsAsString =
          sharedPreferences.getString(Constants.prefKeyAdoptedPets) ?? '';
      alreadyAdoptedPets = json.decode(adoptedPetsAsString);
    } catch (e) {}
    notifyListeners();
  }
}
