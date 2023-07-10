import 'package:challenge_two/ui/shared/colors.dart';
import 'package:challenge_two/ui/shared/custom_widgets/custom_text.dart';
import 'package:challenge_two/ui/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomCart extends StatefulWidget {
  const CustomCart({super.key, required this.cartCount});
  final int? cartCount;
  @override
  State<CustomCart> createState() => _CustomCartState();
}

class _CustomCartState extends State<CustomCart> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: () {
            // Get.to(() => CartView());
          },
          child: SvgPicture.asset(
            'assets/images/ic_shopping_cart.svg',
            color: AppColors.mainOrangeColor,
            width: screenWidth(10),
            height: screenWidth(10),
          ),
        ),
        PositionedDirectional(
          top: -screenWidth(100),
          end: -screenWidth(100),
          child: Visibility(
            visible: widget.cartCount != 0,
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: CustomText(
                text: '${widget.cartCount}',
                textColor: AppColors.mainWhiteColor,
                fontSize: screenWidth(30),
                fontWeight: FontWeight.bold,
              ),
              width: (screenWidth(20)),
              height: (screenWidth(20)),
              decoration: BoxDecoration(
                color: AppColors.mainRedColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.mainWhiteColor,
                  width: 1.5,
                ),
              ),
            ),
          ),
        )
      ],
    );
    // return Stack(
    //   children: [
    //     InkWell(
    //       onTap: () {
    //         Get.to(() => CartView());
    //       },
    //       child: SvgPicture.asset(
    //         'assets/images/ic_shopping_cart.svg',
    //         color: AppColors.mainOrangeColor,
    //         width: screenWidth(12),
    //         height: screenWidth(12),
    //       ),
    //     ),
    //   ],
    // );
  }
}
