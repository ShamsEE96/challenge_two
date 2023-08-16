import 'package:cached_network_image/cached_network_image.dart';
import 'package:challenge_two/core/data/models/apis/product_model.dart';
import 'package:challenge_two/ui/shared/colors.dart';
import 'package:challenge_two/ui/shared/custom_widgets/custom_button.dart';
import 'package:challenge_two/ui/shared/custom_widgets/custom_text.dart';
import 'package:challenge_two/ui/shared/extensions/custom_sized_box_shared.dart';
import 'package:challenge_two/ui/shared/utils.dart';
import 'package:challenge_two/ui/views/product_details_view/product_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductDetailsView extends StatefulWidget {
  ProductDetailsView({
    super.key,
    required this.selecetedProduct,
  });
  final ProductModel selecetedProduct;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  late ProductDetailsController controller;
  @override
  void initState() {
    controller =
        ProductDetailsController(productModel: widget.selecetedProduct);
    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Stack(
          fit: StackFit.expand,
          children: [
            ListView(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: screenWidth(20),
              ),
              children: [
                screenWidth(30).ph,
                CustomText(
                  text: widget.selecetedProduct.title ?? 'nothing found',
                  textColor: AppColors.mainGreyColor,
                  textAlign: TextAlign.start,
                  fontSize: screenHeight(28),
                  fontWeight: FontWeight.w500,
                ),
                screenWidth(30).ph,
                Container(
                  width: screenWidth(1),
                  height: screenWidth(1.25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: widget.selecetedProduct.image!,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Container(
                        width: screenWidth(15),
                        height: screenWidth(15),
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                screenWidth(30).ph,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Description:',
                      textColor: AppColors.mainBlueColor,
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.bold,
                      fontSize: screenHeight(28),
                    ),
                    RatingBar(
                      ignoreGestures: true,
                      initialRating: widget.selecetedProduct.rating!.rate!,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemSize: screenWidth(25),
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
                        widget.selecetedProduct.rating!.rate = rating;
                      },
                    ),
                  ],
                ),
                screenWidth(30).ph,
                CustomText(
                  text: widget.selecetedProduct.description!,
                  textColor: AppColors.mainGreyColor,
                  textAlign: TextAlign.start,
                  fontSize: screenHeight(35),
                  fontWeight: FontWeight.w500,
                ),
                screenWidth(30).ph,
                Row(
                  children: [
                    CustomText(
                      text: 'Category:',
                      textColor: AppColors.mainBlueColor,
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.bold,
                      fontSize: screenHeight(28),
                    ),
                    CustomText(
                      text: " ${widget.selecetedProduct.category!}",
                      textColor: AppColors.mainGreyColor,
                      textAlign: TextAlign.start,
                      fontSize: screenHeight(35),
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                screenWidth(30).ph,
                Row(
                  children: [
                    CustomText(
                      text: 'Price:',
                      textColor: AppColors.mainBlueColor,
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.bold,
                      fontSize: screenHeight(28),
                    ),
                    CustomText(
                      text:
                          " ${widget.selecetedProduct.price!.toStringAsFixed(2)}",
                      textColor: AppColors.mainGreyColor,
                      textAlign: TextAlign.start,
                      fontSize: screenHeight(35),
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                screenHeight(6).ph,
              ],
            ),
            PositionedDirectional(
              bottom: 0,
              child: Container(
                height: screenWidth(4),
                width: screenWidth(1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(30),
                    topEnd: Radius.circular(30),
                  ),
                  shape: BoxShape.rectangle,
                  color: AppColors.mainWhiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.dropShadowColor,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButton(
                      text: "Add To Cart",
                      textColor: AppColors.mainWhiteColor,
                      backgroundColor: AppColors.mainBlueColor,
                      fontSize: screenHeight(28),
                      fontWeight: FontWeight.w500,
                      height: screenHeight(15),
                      width: screenWidth(2.25),
                      onPressed: () {
                        controller.addToCart();
                      },
                    ),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            text: '-',
                            height: screenHeight(20),
                            width: screenWidth(6),
                            backgroundColor: controller.count.value == 1
                                ? AppColors.placeholderGreyColor
                                : AppColors.mainBlueColor,
                            isStadiumShape: false,
                            onPressed: controller.count.value == 1
                                ? null
                                : () {
                                    controller.changeCount(false);
                                  },
                          ),
                          (screenWidth(50)).pw,
                          CustomText(
                            text: "${controller.count.value}",
                            textColor: AppColors.mainGreyColor,
                            fontSize: screenHeight(28),
                            fontWeight: FontWeight.w500,
                          ),
                          (screenWidth(50)).pw,
                          CustomButton(
                            text: '+',
                            height: screenHeight(20),
                            width: screenWidth(6),
                            backgroundColor: AppColors.mainBlueColor,
                            isStadiumShape: false,
                            onPressed: () {
                              controller.changeCount(true);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
