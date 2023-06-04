import 'dart:convert';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption_app/config/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsNotifier extends ChangeNotifier {
  final pet;
  late BuildContext context;

  bool isAdoptAllowed = true;
  late ConfettiController confettiController;

  bool isPlayConfetti = false;

  late SharedPreferences sharedPreferences;

  Map<String, dynamic> alreadyAdoptedPets = {};

  DetailsNotifier(this.context, this.pet);

  Future<void> init() async {
    confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
    sharedPreferences = await SharedPreferences.getInstance();
    try {
      String adoptedPetsAsString =
          sharedPreferences.getString(Constants.prefKeyAdoptedPets) ?? '';
      alreadyAdoptedPets = json.decode(adoptedPetsAsString);
      isAdoptAllowed = !alreadyAdoptedPets.containsKey(pet['id']);
    } catch (e) {}
    notifyListeners();
  }

  void onBackPress() {
    Navigator.pop(context);
  }

  void onClickAdoptMe(String petName) {
    isAdoptAllowed = !isAdoptAllowed;
    if (isPlayConfetti) {
      confettiController.stop();
    } else {
      confettiController.play();
    }
    isPlayConfetti = !isPlayConfetti;

    alreadyAdoptedPets['${pet['id']}'] = DateTime.now().microsecondsSinceEpoch;

    sharedPreferences.setString(
        Constants.prefKeyAdoptedPets, json.encode(alreadyAdoptedPets));
    notifyListeners();
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            elevation: 16,
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.orange.shade100,
              ),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'You have now adopted, ',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: petName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ConfettiWidget(
                    confettiController: confettiController,
                    blastDirection: -pi / 2,
                    gravity: 0.3,
                    numberOfParticles: 20,
                    emissionFrequency: 0.5,
                  ),
                ],
              )),
            ),
          );
        });
  }
}
