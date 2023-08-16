import 'package:challenge_two/ui/shared/colors.dart';
import 'package:challenge_two/ui/shared/utils.dart';
import 'package:challenge_two/ui/views/main_view/all_products_view/all_products_view.dart';
import 'package:challenge_two/ui/views/main_view/cart_view/cart_view.dart';
import 'package:challenge_two/ui/views/main_view/home_view/home_view.dart';
import 'package:challenge_two/ui/views/main_view/main_controller.dart';
import 'package:challenge_two/ui/views/main_view/main_view_widgets/bottom_navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  MainController controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        key: controller.scaffoldKey,
        // drawer: CustomDrawer(
        //   drawerWidth: screenWidth(2),
        // ),
        body: Obx(
          () {
            return Stack(
              children: [
                PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controller.pageController,
                  children: [
                    AllProductsView(),
                    HomeView(),
                    CartView(),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: BottomNavigationWidget(
                    cartCount: cartService.cartCount.value,
                    bottomNavigationEnum: controller.selectedPage.value,
                    onTap: (selectedEnum, pageNumber) {
                      controller.pageNavigation(selectedEnum, pageNumber);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
