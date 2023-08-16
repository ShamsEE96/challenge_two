import 'package:challenge_two/ui/shared/colors.dart';
import 'package:challenge_two/ui/shared/custom_widgets/custom_text.dart';
import 'package:challenge_two/ui/shared/extensions/custom_sized_box_shared.dart';
import 'package:challenge_two/ui/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCategoryChallenge extends StatelessWidget {
  CustomCategoryChallenge({
    super.key,
    this.text,
    this.textColor,
    this.backgroundColor,
    this.borderColor,
    required this.onPressed,
    this.imageName,
    this.width,
    this.height,
    this.imageColor,
    this.imageWidth,
    this.imageHeight,
    this.fontWeight,
    this.fontSize,
  });

  final String? text;
  final String? imageName;
  final Color? imageColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? backgroundColor;
  final Function? onPressed;
  final double? width;
  final double? height;
  final double? imageWidth;
  final double? imageHeight;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? screenWidth(1.1),
      height: height ?? screenHeight(12),
      child: ElevatedButton(
        onPressed: () {
          if (onPressed != null) onPressed!();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imageName != null) ...[
              SvgPicture.asset(
                'assets/images/$imageName.svg',
                color: imageColor,
                width: imageWidth,
                height: imageHeight,
              ),
              (screenWidth(20)).pw,
            ],
            CustomText(
              text: text ?? "",
              textColor: textColor,
              fontWeight: fontWeight ?? FontWeight.bold,
              fontSize: fontSize ?? screenWidth(25),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          side: borderColor != null
              ? BorderSide(
                  width: 1.0,
                  color: borderColor!,
                )
              : null,
          backgroundColor: backgroundColor ?? AppColors.mainOrangeColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          // fixedSize: Size(
          //   width ?? screenWidth(1.1),
          //   height ?? screenHeight(12),
          // ),
        ),
      ),
    );
  }
}
