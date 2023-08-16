import 'package:challenge_two/ui/shared/colors.dart';
import 'package:challenge_two/ui/shared/custom_widgets/custom_product.dart';
import 'package:challenge_two/ui/shared/custom_widgets/custom_text.dart';
import 'package:challenge_two/ui/shared/custom_widgets/home_view_category.dart';
import 'package:challenge_two/ui/shared/extensions/custom_sized_box_shared.dart';
import 'package:challenge_two/ui/shared/utils.dart';
import 'package:challenge_two/ui/views/main_view/home_view/home_controller.dart';
import 'package:challenge_two/ui/views/product_details_view/product_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: screenWidth(20),
          ),
          child: CustomText(
            text: 'Categories',
            textAlign: TextAlign.start,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth(16),
          ),
        ),
        SizedBox(
          height: screenHeight(8),
          // height: screenWidth(2),
          child: Obx(
            () {
              return controller.isCategoryLoading
                  ? SpinKitCircle(
                      color: AppColors.mainOrangeColor,
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.categoryList.length,
                      itemBuilder: (BuildContext context, int index) {
                        String category = controller.categoryList[index];
                        bool isSelected =
                            category == controller.selectedCategory.value;

                        return HomeViewCategoryWidget(
                          text: controller.categoryList[index],
                          onTap: () {
                            controller.getProductByCategory(
                                categoryName: category);
                          },
                          isSelected: isSelected,
                        );
                      },
                    );
            },
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: screenWidth(20),
          ),
          child: CustomText(
            text: 'Products',
            textAlign: TextAlign.start,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth(16),
          ),
        ),
        SizedBox(
          height: screenHeight(1.5),
          child: Obx(
            () {
              return controller.isProductLoading
                  ? SpinKitCircle(
                      color: AppColors.mainOrangeColor,
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: screenWidth(1.5),
                        crossAxisCount: 2,
                      ),
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.productlList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomProductItem(
                          title: controller.productlList[index].title,
                          imageUrl: controller.productlList[index].image,
                          onTap: () {
                            Get.to(
                              () => ProductDetailsView(
                                selecetedProduct:
                                    controller.productlList[index],
                              ),
                            );
                          },
                          ratingAmount:
                              controller.productlList[index].rating!.rate,
                          price: controller.productlList[index].price,
                        );
                      },
                    );
            },
          ),
        ),
        screenHeight(1).ph,
      ],
    );
  }
}
