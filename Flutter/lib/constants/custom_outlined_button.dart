import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quick_bite/constants/colors.dart';

Widget CustomOutlinedButton(
  double screenWidth,
  double screenHeight,
  String label,
  void Function() onTap,
) {
  return SizedBox(
    width: screenWidth * 0.6,
    height: screenHeight * 0.075,
    child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          side: BorderSide(color: primaryBrown),
        ),
        onPressed: onTap,
        child: AutoSizeText(
          label,
          style: TextStyle(
              color: primaryBrown, fontSize: 20, fontWeight: FontWeight.bold),
        )),
  );
}
