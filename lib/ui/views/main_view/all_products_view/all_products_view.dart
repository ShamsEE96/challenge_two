import 'package:challenge_two/ui/shared/colors.dart';
import 'package:challenge_two/ui/shared/custom_widgets/custom_product.dart';
import 'package:challenge_two/ui/shared/custom_widgets/custom_text.dart';
import 'package:challenge_two/ui/shared/custom_widgets/custom_text_field.dart';
import 'package:challenge_two/ui/shared/extensions/custom_sized_box_shared.dart';
import 'package:challenge_two/ui/shared/utils.dart';
import 'package:challenge_two/ui/views/main_view/all_products_view/all_products_controller.dart';
import 'package:challenge_two/ui/views/product_details_view/product_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class AllProductsView extends StatefulWidget {
  const AllProductsView({super.key});

  @override
  State<AllProductsView> createState() => _AllProductsViewState();
}

class _AllProductsViewState extends State<AllProductsView> {
  AllProductsController controller = Get.put(AllProductsController());

  @override
  void initState() {
    super.initState();
    controller.resultList.value = controller.productlList;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsetsDirectional.symmetric(
            vertical: screenHeight(40),
            horizontal: screenWidth(20),
          ),
          child: CustomText(
            text: 'All Products',
            textAlign: TextAlign.start,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth(16),
          ),
        ),
        Center(
          child: CustomTextFormField(
            hintText: 'Search ...',
            controller: controller.searchController,
            fillColor: AppColors.mainWhiteColor,
            hintTextColor: AppColors.placeholderGreyColor,
            prefixIcon: Icon(Icons.search),
            prefixIconColor: AppColors.mainGreyColor,
            onChanged: (p0) {
              controller.filterSearchResults(query: p0);
            },
          ),
        ),
        screenHeight(20).ph,
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
                      itemCount: controller.resultList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomProductItem(
                          title: controller.resultList[index].title,
                          imageUrl: controller.resultList[index].image,
                          onTap: () {
                            Get.to(
                              () => ProductDetailsView(
                                selecetedProduct: controller.resultList[index],
                              ),
                            );
                          },
                          ratingAmount:
                              controller.resultList[index].rating!.rate,
                          price: controller.resultList[index].price,
                        );
                      },
                    );
            },
          ),
        ),
      ],
    );
  }
}
