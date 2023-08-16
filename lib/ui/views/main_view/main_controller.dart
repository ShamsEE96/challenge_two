import 'package:challenge_two/core/enums/bottom_navigation.dart';
import 'package:challenge_two/core/services/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends BaseController {
  Rx<BottomNavigationEnum> selectedPage = BottomNavigationEnum.HOME.obs;
  PageController pageController = PageController(initialPage: 1);
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void pageNavigation(BottomNavigationEnum selectedEnum, int pageNumber) {
    pageController.animateToPage(
      pageNumber,
      duration: Duration(
        microseconds: 500,
      ),
      curve: Curves.easeInCirc,
    );
    selectedPage.value = selectedEnum;
  }
}
