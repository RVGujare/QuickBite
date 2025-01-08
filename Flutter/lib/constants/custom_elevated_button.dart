import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

Widget CustomElevatedButton(
    double screenWidth,
    double screenHeight,
    String label,
    BuildContext context,
    Color bgColor,
    Color textColor,
    void Function() onTap) {
  return SizedBox(
    width: screenWidth * 0.9,
    height: screenHeight * 0.075,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: onTap,
        child: AutoSizeText(
          label,
          style: TextStyle(color: textColor, fontSize: 20),
        )),
  );
}
