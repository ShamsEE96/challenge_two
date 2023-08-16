import 'package:challenge_two/core/enums/bottom_navigation.dart';
import 'package:challenge_two/core/translation/app_translation.dart';
import 'package:challenge_two/ui/shared/colors.dart';
import 'package:challenge_two/ui/shared/extensions/custom_sized_box_shared.dart';
import 'package:challenge_two/ui/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../shared/custom_widgets/custom_cart.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({
    super.key,
    required this.bottomNavigationEnum,
    required this.onTap,
    this.cartCount,
  });

  final BottomNavigationEnum bottomNavigationEnum;
  final Function(BottomNavigationEnum, int) onTap;
  final int? cartCount;

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: screenWidth(1),
          height: screenHeight(8),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            color: AppColors.mainWhiteColor,
            boxShadow: [
              BoxShadow(
                color: AppColors.mainGreyColor,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: screenWidth(30),
          right: 0,
          left: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: screenWidth(38),
              horizontal: screenWidth(23),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NavItemTestWidget(
                  imageName: 'products-svgrepo-com',
                  text: tr('key_main_view_bottom_navigation_bar_item_menu'),
                  isSelected:
                      widget.bottomNavigationEnum == BottomNavigationEnum.ALL,
                  onTap: () {
                    widget.onTap(BottomNavigationEnum.ALL, 0);
                  },
                ),
                NavItemTestWidget(
                  imageName: 'home-svgrepo-com',
                  text: tr('key_main_view_bottom_navigation_bar_item_offers'),
                  isSelected:
                      widget.bottomNavigationEnum == BottomNavigationEnum.HOME,
                  onTap: () {
                    widget.onTap(BottomNavigationEnum.HOME, 1);
                  },
                ),
                // (screenWidth(4)).pw,
                NavItemTestWidget(
                  imageName: 'cart-svgrepo-com',
                  text: tr('key_main_view_bottom_navigation_bar_item_profile'),
                  isSelected:
                      widget.bottomNavigationEnum == BottomNavigationEnum.CART,
                  onTap: () {
                    widget.onTap(BottomNavigationEnum.CART, 2);
                  },
                  cartCount: widget.cartCount,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget navItem({
    required String text,
    required String imageName,
    required bool isSelected,
    required Function onTap,
  }) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/images/$imageName.svg',
            color: isSelected
                ? AppColors.mainOrangeColor
                : AppColors.placeholderGreyColor,
            width: screenWidth(17),
            height: screenWidth(17),
          ),
          (screenWidth(35)).ph,
          // Text(
          //   text,
          //   style: TextStyle(
          //     color: isSelected
          //         ? AppColors.mainOrangeColor
          //         : AppColors.placeholderGreyColor,
          //     fontSize: screenWidth(30),
          //   ),
          // )
        ],
      ),
    );
  }
}

// class BottomNavigationClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path0 = Path();
//     path0.moveTo(0, 0);
//     path0.lineTo(size.width * 0.3381500, 0);
//     path0.quadraticBezierTo(size.width * 0.3731500, size.height * 0.0069000,
//         size.width * 0.3757000, size.height * 0.1236000);
//     path0.quadraticBezierTo(size.width * 0.4022000, size.height * 0.5633000,
//         size.width * 0.5006000, size.height * 0.5896000);
//     path0.quadraticBezierTo(size.width * 0.5955500, size.height * 0.5727000,
//         size.width * 0.6200000, size.height * 0.1240000);
//     path0.quadraticBezierTo(size.width * 0.6204500, size.height * -0.0157000,
//         size.width * 0.6646000, 0);
//     path0.lineTo(size.width, 0);
//     path0.lineTo(size.width, size.height);
//     path0.lineTo(0, size.height);
//     path0.lineTo(0, 0);
//     path0.lineTo(size.width * 0.6225000, size.height * 0.6100000);
//     return path0;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => true;
// }

// class _ClipShadowShadowPainter extends CustomPainter {
//   final Shadow shadow;
//   final CustomClipper<Path> clipper;

//   _ClipShadowShadowPainter({required this.shadow, required this.clipper});

//   @override
//   void paint(Canvas canvas, Size size) {
//     var paint = shadow.toPaint();
//     var clipPath = clipper.getClip(size).shift(shadow.offset);
//     canvas.drawPath(clipPath, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
