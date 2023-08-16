import 'package:cached_network_image/cached_network_image.dart';
import 'package:challenge_two/core/enums/message_type.dart';
import 'package:challenge_two/ui/shared/colors.dart';
import 'package:challenge_two/ui/shared/custom_widgets/custom_button.dart';
import 'package:challenge_two/ui/shared/custom_widgets/custom_text.dart';
import 'package:challenge_two/ui/shared/custom_widgets/custom_toast.dart';
import 'package:challenge_two/ui/shared/extensions/custom_sized_box_shared.dart';
import 'package:challenge_two/ui/shared/utils.dart';
import 'package:challenge_two/ui/views/main_view/cart_view/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: screenWidth(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Cart',
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth(12),
                ),
              ],
            ),
          ),
          Obx(
            () {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: controller.cartList.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        border: Border.all(),
                        color: AppColors.mainWhiteColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth(30),
                          vertical: screenWidth(20),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Container(
                                    width: screenWidth(4),
                                    height: screenWidth(3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl: controller.cartList[index]
                                            .productModel!.image!,
                                        fit: BoxFit.contain,
                                        placeholder: (context, url) =>
                                            Container(
                                          width: screenWidth(15),
                                          height: screenWidth(15),
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            screenWidth(50).pw,
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          controller.removeFromCartList(
                                              controller.cartList[index]);
                                        },
                                        child: SvgPicture.asset(
                                          'assets/images/delete-left-svgrepo-com.svg',
                                          color: AppColors.mainRedColor,
                                          width: screenWidth(15),
                                          height: screenWidth(15),
                                        ),
                                      )
                                    ],
                                  ),
                                  CustomText(
                                    text: controller.cartList[index]
                                            .productModel!.title ??
                                        'nothing found',
                                    textColor: AppColors.mainGreyColor,
                                    textAlign: TextAlign.start,
                                    fontSize: screenHeight(45),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  screenWidth(40).ph,
                                  Row(
                                    children: [
                                      CustomText(
                                        text: 'Price:',
                                        textColor: AppColors.mainBlueColor,
                                        textAlign: TextAlign.start,
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenHeight(45),
                                      ),
                                      CustomText(
                                        text:
                                            " ${controller.cartList[index].productModel!.price!.toStringAsFixed(2)}",
                                        textColor: AppColors.mainGreyColor,
                                        textAlign: TextAlign.start,
                                        fontSize: screenHeight(45),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                  screenWidth(40).ph,
                                  Row(
                                    children: [
                                      CustomText(
                                        text: 'Total:',
                                        textColor: AppColors.mainBlueColor,
                                        textAlign: TextAlign.start,
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenHeight(45),
                                      ),
                                      CustomText(
                                        text:
                                            " ${controller.cartList[index].total!.toStringAsFixed(2)}",
                                        textColor: AppColors.mainGreyColor,
                                        textAlign: TextAlign.start,
                                        fontSize: screenHeight(45),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Obx(
                                        () => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomButton(
                                              text: '-',
                                              height: screenHeight(20),
                                              width: screenWidth(6),
                                              backgroundColor: controller
                                                          .cartList[index]
                                                          .count ==
                                                      1
                                                  ? AppColors
                                                      .placeholderGreyColor
                                                  : AppColors.mainBlueColor,
                                              isStadiumShape: false,
                                              onPressed: controller
                                                          .cartList[index]
                                                          .count ==
                                                      1
                                                  ? null
                                                  : () {
                                                      controller.changeCount(
                                                        increase: false,
                                                        cartModel: controller
                                                            .cartList[index],
                                                      );
                                                    },
                                            ),
                                            (screenWidth(50)).pw,
                                            CustomText(
                                              text:
                                                  "${controller.cartList[index].count}",
                                              textColor:
                                                  AppColors.mainGreyColor,
                                              fontSize: screenHeight(28),
                                              fontWeight: FontWeight.w500,
                                            ),
                                            (screenWidth(50)).pw,
                                            CustomButton(
                                              text: '+',
                                              height: screenHeight(20),
                                              width: screenWidth(6),
                                              backgroundColor:
                                                  AppColors.mainBlueColor,
                                              isStadiumShape: false,
                                              onPressed: () {
                                                controller.changeCount(
                                                  increase: true,
                                                  cartModel: controller
                                                      .cartList[index],
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          Obx(
            () {
              return Column(
                children: [
                  Container(
                    height: 1,
                    width: screenWidth(1.15),
                    color: AppColors.mainBlueColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: '         SubTotal : ',
                              fontWeight: FontWeight.bold,
                              textColor: AppColors.mainBlueColor,
                            ),
                            CustomText(
                              text:
                                  '${cartService.subTotal.value.toStringAsFixed(2)} SP                 ',
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        Container(
                          height: 1,
                          width: screenWidth(1.25),
                          color: AppColors.mainBlueColor.withOpacity(0.5),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: '         Tax : ',
                              fontWeight: FontWeight.bold,
                              textColor: AppColors.mainBlueColor,
                            ),
                            CustomText(
                              text:
                                  '${cartService.tax.value.toStringAsFixed(2)} SP                 ',
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        Container(
                          height: 1,
                          width: screenWidth(1.25),
                          color: AppColors.mainBlueColor.withOpacity(0.5),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: '         Delivary Fee : ',
                              fontWeight: FontWeight.bold,
                              textColor: AppColors.mainBlueColor,
                            ),
                            CustomText(
                              text:
                                  '${cartService.deliverFees.value.toStringAsFixed(2)} SP                 ',
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        Container(
                          height: 1,
                          width: screenWidth(1.25),
                          color: AppColors.mainBlueColor.withOpacity(0.5),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: '         Total : ',
                              fontWeight: FontWeight.bold,
                              textColor: AppColors.mainRedColor,
                            ),
                            CustomText(
                              text:
                                  '${cartService.total.value.toStringAsFixed(2)} SP                 ',
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    width: screenWidth(1.15),
                    color: AppColors.mainBlueColor,
                  ),
                  screenHeight(20).ph,
                  CustomButton(
                    text: 'Placed Order',
                    fontSize: screenHeight(25),
                    fontWeight: FontWeight.w500,
                    backgroundColor: AppColors.mainBlueColor,
                    onPressed: () {
                      if (cartService.cartCount != 0) {
                        controller.checkout();
                      } else {
                        CustomToast.showMessage(
                          message: 'Your Cart is Empty',
                          messageType: MessageType.WARNING,
                        );
                      }
                    },
                  ),
                  Visibility(
                    visible: cartService.cartCount != 0,
                    child: TextButton(
                      onPressed: () {
                        cartService.clearCart();
                      },
                      child: CustomText(
                        text: "Empty Cart",
                        textColor: AppColors.mainRedColor,
                      ),
                    ),
                  )
                ],
              );
            },
          ),
          screenHeight(8).ph,
        ],
      ),
    );
  }
}
