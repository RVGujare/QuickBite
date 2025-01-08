import 'package:flutter/material.dart';

Widget smallHeightBetweenComponents(double screenHeight) {
  return SizedBox(
    height: screenHeight * 0.03,
  );
}

Widget mediumHeightBetweenComponents(double screenHeight) {
  return SizedBox(
    height: screenHeight * 0.1,
  );
}

Widget smallWidthBetweenComponents(double screenWidth) {
  return SizedBox(
    width: screenWidth * 0.03,
  );
}

Widget mediumWidthBetweenComponents(double screenWidth) {
  return SizedBox(
    width: screenWidth * 0.05,
  );
}
