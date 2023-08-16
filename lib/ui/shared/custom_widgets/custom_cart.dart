import 'package:challenge_two/ui/shared/colors.dart';
import 'package:challenge_two/ui/shared/custom_widgets/custom_text.dart';
import 'package:challenge_two/ui/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NavItemTestWidget extends StatefulWidget {
  const NavItemTestWidget({
    super.key,
    this.cartCount,
    required this.text,
    required this.imageName,
    required this.isSelected,
    required this.onTap,
  });
  final int? cartCount;
  final String? text;
  final String? imageName;
  final bool? isSelected;
  final Function? onTap;

  @override
  State<NavItemTestWidget> createState() => _NavItemTestWidgetState();
}

class _NavItemTestWidgetState extends State<NavItemTestWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: () {
            widget.onTap!();
          },
          child: SvgPicture.asset(
            'assets/images/${widget.imageName}.svg',
            color: widget.isSelected!
                ? AppColors.mainBlueColor
                : AppColors.mainGreyColor,
            width: screenWidth(10),
            height: screenWidth(10),
          ),
        ),
        PositionedDirectional(
          bottom: -screenWidth(100),
          end: -screenWidth(100),
          child: widget.cartCount != null
              ? Visibility(
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
                )
              : SizedBox(),
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








// import 'package:challenge_two/ui/shared/colors.dart';
// import 'package:challenge_two/ui/shared/custom_widgets/custom_text.dart';
// import 'package:challenge_two/ui/shared/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';

// class NavItemTestWidget extends StatefulWidget {
//   const NavItemTestWidget({super.key, required this.cartCount});
//   final int? cartCount;
//   @override
//   State<NavItemTestWidget> createState() => _NavItemTestWidgetState();
// }

// class _NavItemTestWidgetState extends State<NavItemTestWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         InkWell(
//           onTap: () {
//             // Get.to(() => CartView());
//           },
//           child: SvgPicture.asset(
//             'assets/images/ic_shopping_cart.svg',
//             color: AppColors.mainOrangeColor,
//             width: screenWidth(10),
//             height: screenWidth(10),
//           ),
//         ),
//         PositionedDirectional(
//           top: screenWidth(100),
//           end: screenWidth(100),
//           child: Visibility(
//             visible: widget.cartCount != 0,
//             child: Container(
//               clipBehavior: Clip.antiAliasWithSaveLayer,
//               child: CustomText(
//                 text: '${widget.cartCount}',
//                 textColor: AppColors.mainWhiteColor,
//                 fontSize: screenWidth(30),
//                 fontWeight: FontWeight.bold,
//               ),
//               width: (screenWidth(20)),
//               height: (screenWidth(20)),
//               decoration: BoxDecoration(
//                 color: AppColors.mainRedColor,
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: AppColors.mainWhiteColor,
//                   width: 1.5,
//                 ),
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//     // return Stack(
//     //   children: [
//     //     InkWell(
//     //       onTap: () {
//     //         Get.to(() => CartView());
//     //       },
//     //       child: SvgPicture.asset(
//     //         'assets/images/ic_shopping_cart.svg',
//     //         color: AppColors.mainOrangeColor,
//     //         width: screenWidth(12),
//     //         height: screenWidth(12),
//     //       ),
//     //     ),
//     //   ],
//     // );
//   }
// }
