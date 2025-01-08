import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quick_bite/constants/colors.dart';

Widget outletContainer(double screenWidth, double screenHeight,
    String imageName, String title, void Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: screenHeight * 0.3,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius:
                BorderRadius.circular(8), // Rounded corners for the image
            child: Container(
              height: screenHeight * 0.25,
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                border: Border.all(color: black, width: 0.8),
              ),
              child: CachedNetworkImage(
                imageUrl: imageName,
                placeholder: (context, url) => Image.asset(
                  'assets/restaurant_placeholder.png',
                  fit: BoxFit.cover,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.22,
            child: Container(
              width: screenWidth * 0.89,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: black, width: 0.6),
              ),
              padding: EdgeInsets.all(screenHeight * 0.01),
              child: Center(
                child: AutoSizeText(
                  title,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  minFontSize: 16,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
