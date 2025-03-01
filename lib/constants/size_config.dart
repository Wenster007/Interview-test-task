import 'package:flutter/material.dart';

class SizeConfig {
  static late double _screenWidth;
  static late double _screenHeight;

  static void init(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    _screenWidth = mediaQueryData.size.width;
    _screenHeight = mediaQueryData.size.height;
  }

  static double scaleHeight(double figmaHeight) {
    // Base height used in Figma (e.g., 812px)
    const double baseHeight = 812.0;
    return (figmaHeight / baseHeight) * _screenHeight + 2;
  }

  static double scaleWidth(double figmaWidth) {
    // Base width used in Figma (e.g., 375px)
    const double baseWidth = 375.0;
    return (figmaWidth / baseWidth) * _screenWidth + 1;
  }
}
