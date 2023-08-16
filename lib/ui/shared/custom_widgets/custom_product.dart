import 'package:cached_network_image/cached_network_image.dart';
import 'package:challenge_two/ui/shared/colors.dart';
import 'package:challenge_two/ui/shared/custom_widgets/custom_text.dart';
import 'package:challenge_two/ui/shared/extensions/custom_sized_box_shared.dart';
import 'package:challenge_two/ui/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomProductItem extends StatefulWidget {
  CustomProductItem({
    super.key,
    required this.title,
    required this.onTap,
    required this.imageUrl,
    this.ratingAmount,
    required this.price,
  });
  final String? title;
  final Function onTap;
  final String? imageUrl;
  double? ratingAmount = 0.0;
  final double? price;

  @override
  State<CustomProductItem> createState() => _CustomProductItemState();
}

class _CustomProductItemState extends State<CustomProductItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          widget.onTap();
        },
        child: Container(
          clipBehavior: Clip.antiAlias,
          alignment: AlignmentDirectional.center,
          width: screenWidth(3),
          decoration: BoxDecoration(
            color: AppColors.mainWhiteColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.mainGreyColor,
            ),
          ),
          child: Column(
            children: [
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: Container(
                  // clipBehavior: Clip.antiAlias,
                  width: screenWidth(3),
                  // alignment: AlignmentDirectional.topEnd,
                  decoration: BoxDecoration(
                    color: AppColors.placeholderGreyColor,
                    borderRadius: BorderRadiusDirectional.only(
                        bottomStart: Radius.circular(20)),
                    // border: Border.all(
                    //   color: AppColors.mainGreyColor,
                    // ),
                  ),
                  child: RatingBar(
                    allowHalfRating: true,
                    ignoreGestures: true,
                    initialRating: widget.ratingAmount!,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemSize: screenWidth(30),
                    ratingWidget: RatingWidget(
                      full: SvgPicture.asset(
                        'assets/images/ic_star_full.svg',
                        color: AppColors.mainBlueColor,
                      ),
                      half: SvgPicture.asset(
                        'assets/images/ic_star_half.svg',
                        color: AppColors.mainBlueColor,
                      ),
                      empty: SvgPicture.asset(
                        'assets/images/ic_star_empty.svg',
                        color: AppColors.mainBlueColor,
                      ),
                    ),
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    onRatingUpdate: (rating) {
                      widget.ratingAmount = rating;
                    },
                  ),
                ),
              ),
              screenWidth(30).ph,
              Container(
                width: screenWidth(4),
                height: screenWidth(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUrl!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: screenWidth(15),
                      height: screenWidth(15),
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              screenWidth(25).ph,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: widget.title ?? 'nothing found',
                      textColor: AppColors.mainGreyColor,
                      textAlign: TextAlign.start,
                      fontSize: screenWidth(30),
                      fontWeight: FontWeight.bold,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    screenWidth(30).ph,
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: 'Price :',
                          textColor: AppColors.mainBlueColor,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(
                          text: ' ${widget.price}',
                          textColor: AppColors.mainGreyColor,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
