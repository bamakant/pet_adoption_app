import 'package:flutter/material.dart';
import 'package:pet_adoption_app/utils/widgets/pet_image.dart';

class PetWidget extends StatelessWidget {
  const PetWidget({
    Key? key,
    this.onTap,
    required this.pet,
    required this.isAlreadyAdopted,
  }) : super(key: key);

  final GestureTapCallback? onTap;
  final pet;
  final bool isAlreadyAdopted;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Stack(children: [
        Card(
          color: Theme.of(context).cardColor,
          margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Hero(
                    tag: pet["id"],
                    child: PetImageWidget(imagePath: pet["image"])),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pet["name"],
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${pet["age"]} Old',
                      style: TextStyle(
                        fontSize: 14,
                        color: isDarkMode ? Colors.white70 : Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Gender: ${pet["sex"]}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white60 : Colors.black54,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12.0),
                bottomLeft: Radius.circular(4.0),
              ),
            ),
            child: Text(
              pet['rate'].toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        !isAlreadyAdopted
            ? Positioned(
                left: 11,
                top: 31,
                child: Transform.rotate(
                  angle: -0.7,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: const BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(0),
                      ),
                    ),
                    child: const Text(
                      'Already Adopted',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ]),
    );
  }
}
