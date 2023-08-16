import 'package:challenge_two/ui/shared/colors.dart';
import 'package:challenge_two/ui/shared/custom_widgets/custom_button.dart';
import 'package:challenge_two/ui/shared/custom_widgets/custom_text.dart';
import 'package:challenge_two/ui/shared/extensions/custom_sized_box_shared.dart';
import 'package:challenge_two/ui/shared/utils.dart';
import 'package:challenge_two/ui/views/checkout_view/checkout_controller.dart';
import 'package:challenge_two/ui/views/main_view/main_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  void initState() {
    storage.setOrderPlaced(true);
    super.initState();
  }

  CheckoutController controller = Get.put(CheckoutController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        cartService.clearCart();
        Get.off(() => MainView());

        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: screenWidth(16),
                ),
                child: Column(
                  children: [
                    CustomText(
                      text: 'Your order placed successfully',
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.bold,
                      fontSize: screenHeight(20),
                    ),
                    screenWidth(20).ph,
                    Row(
                      children: [
                        CustomText(
                          text: 'Order NO: ',
                          textColor: AppColors.mainBlueColor,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.bold,
                          fontSize: screenHeight(45),
                        ),
                        screenWidth(20).ph,
                        CustomText(
                          text: ' #123910',
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.bold,
                          fontSize: screenHeight(45),
                        ),
                      ],
                    ),
                    screenWidth(40).ph,
                    Row(
                      children: [
                        CustomText(
                          text: 'Order NO: ',
                          textColor: AppColors.mainBlueColor,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.bold,
                          fontSize: screenHeight(45),
                        ),
                        screenWidth(20).ph,
                        Obx(
                          () {
                            return CustomText(
                              text: ' ${cartService.cartCount.value}',
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.bold,
                              fontSize: screenHeight(45),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
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
                        text: 'Continue Shopping',
                        fontSize: screenHeight(25),
                        fontWeight: FontWeight.w500,
                        backgroundColor: AppColors.mainBlueColor,
                        onPressed: () {
                          cartService.clearCart();
                          Get.off(() => MainView());
                        },
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
