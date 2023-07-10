import 'package:challenge_two/app/my_app.dart';
import 'package:challenge_two/ui/shared/colors.dart';
import 'package:challenge_two/ui/shared/custom_widgets/custom_text.dart';
import 'package:challenge_two/ui/shared/extensions/custom_sized_box_shared.dart';
import 'package:challenge_two/ui/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppLanguage extends StatefulWidget {
  final Function? extraFunction;
  const CustomAppLanguage({super.key, this.extraFunction});

  @override
  State<CustomAppLanguage> createState() => _CustomAppLanguageState();
}

class _CustomAppLanguageState extends State<CustomAppLanguage> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.defaultDialog(
          title: 'Choose App Language',
          content: Column(
            children: [
              InkWell(
                onTap: () {
                  storage.setAppLanguage('en');
                  Get.updateLocale(getLocale());
                  Get.back();
                  if (widget.extraFunction != null) widget.extraFunction!();
                },
                child: CustomText(text: 'English'),
              ),
              (screenWidth(20)).ph,
              InkWell(
                onTap: () {
                  storage.setAppLanguage('ar');
                  Get.updateLocale(getLocale());
                  Get.back();
                  if (widget.extraFunction != null) widget.extraFunction!();
                },
                child: CustomText(text: 'العربية'),
              ),
              (screenWidth(20)).ph,
              InkWell(
                onTap: () {
                  storage.setAppLanguage('tr');
                  Get.updateLocale(getLocale());
                  Get.back();
                  if (widget.extraFunction != null) widget.extraFunction!();
                },
                child: CustomText(text: 'Türkçe'),
              ),
            ],
          ),
        );
      },
      child: Icon(
        Icons.language,
        color: AppColors.mainOrangeColor,
      ),
    );
  }
}
