import 'package:challenge_two/ui/shared/colors.dart';
import 'package:challenge_two/ui/shared/custom_widgets/custom_text.dart';
import 'package:challenge_two/ui/shared/utils.dart';
import 'package:flutter/material.dart';

class HomeViewCategoryWidget extends StatefulWidget {
  const HomeViewCategoryWidget({
    super.key,
    this.text,
    required this.isSelected,
    required this.onTap,
  });
  final String? text;
  final Function onTap;
  final bool isSelected;

  @override
  State<HomeViewCategoryWidget> createState() => _HomeViewCategoryWidgetState();
}

class _HomeViewCategoryWidgetState extends State<HomeViewCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          widget.onTap();
        },
        child: Container(
          alignment: AlignmentDirectional.center,
          width: screenWidth(2),
          height: 50,
          decoration: BoxDecoration(
            color: widget.isSelected
                ? AppColors.mainBlueColor
                : AppColors.mainWhiteColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: CustomText(
            text: widget.text ?? 'nothing found',
            textColor: widget.isSelected
                ? AppColors.mainWhiteColor
                : AppColors.mainGreyColor,
          ),
        ),
      ),
    );
  }
}
