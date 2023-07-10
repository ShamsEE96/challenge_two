import 'package:challenge_two/ui/shared/utils.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.textColor,
    this.textAlign,
    this.fontSize,
    this.fontWeight,
  });

  final String text;
  final Color? textColor;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.center,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize ?? screenWidth(25), // fontsize 14p in xD
        fontWeight: fontWeight,
      ),
    );
  }
}




// Big Text size fontSize: size.width * 0.1,
// Small text size fontSize: size.width * 0.04,