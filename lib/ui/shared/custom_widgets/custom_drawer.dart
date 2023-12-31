import 'package:challenge_two/app/my_app.dart';
import 'package:challenge_two/ui/shared/colors.dart';
import 'package:challenge_two/ui/shared/custom_widgets/custom_text.dart';
import 'package:challenge_two/ui/shared/extensions/custom_sized_box_shared.dart';
import 'package:challenge_two/ui/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({
    super.key,
    this.drawerBackgroundColor,
    required this.drawerWidth,
    this.drawerheight,
  });
  final double? drawerWidth;
  final double? drawerheight;
  final Color? drawerBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: drawerheight,
      width: drawerWidth,
      color: drawerBackgroundColor ?? AppColors.mainWhiteColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // IconButton(
            //   onPressed: () {
            //     storage.clearTokenInfo();
            //     Get.delete<SplashScreenController>();
            //     Get.off(() => SplashScreenView());
            //   },
            //   icon: Icon(Icons.logout),
            // ),
            Text('Options 1'),
            Text('Options 2'),
            InkWell(
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
                        },
                        child: CustomText(text: 'English'),
                      ),
                      (screenWidth(20)).ph,
                      InkWell(
                        onTap: () {
                          storage.setAppLanguage('ar');
                          Get.updateLocale(getLocale());
                          Get.back();
                        },
                        child: CustomText(text: 'العربية'),
                      ),
                      (screenWidth(20)).ph,
                      InkWell(
                        onTap: () {
                          storage.setAppLanguage('tr');
                          Get.updateLocale(getLocale());
                          Get.back();
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
            ),
            // IconButton(
            //   onPressed: () async {
            //     await UrlLauncherUtil.startLaunchUrl(
            //       url: Uri.parse('https://www.google.com'),
            //       type: UrlType.WEB,
            //     );
            //   },
            //   icon: Icon(Icons.launch),
            // ),
          ],
        ),
      ),
    );
  }
}
