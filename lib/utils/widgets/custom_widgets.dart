import 'package:flutter/material.dart';

class CustomWidgets {
  static ElevatedButton filledButton(
          {required String text,
          required VoidCallback onPressed,
          required isEnabled,
          EdgeInsets? padding,
          double? height = 45,
          Widget? child}) =>
      ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: isEnabled
            ? ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromRGBO(35, 85, 252, 1)))
            : ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromRGBO(175, 196, 255, 1))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (child != null) child,
            Container(
              height: height,
              padding: padding,
              alignment: Alignment.center,
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      );
}
