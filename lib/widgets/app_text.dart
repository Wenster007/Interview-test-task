import 'package:flutter/material.dart';
import 'package:test2/constants/app_colors.dart';
import 'package:test2/constants/font_sizes.dart';

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.fontColor,
    this.alignment, this.overflow, this.fontFamily,
  });

  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final TextAlign? alignment;
  final TextOverflow? overflow;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize ?? FontSizes.pixel12,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: fontColor ?? AppColors.black,
        fontFamily: fontFamily ?? 'Poppins',
      ),
      textAlign: alignment ?? TextAlign.center,
      overflow: overflow ?? TextOverflow.visible,
    );
  }
}
