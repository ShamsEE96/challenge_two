import 'package:bot_toast/bot_toast.dart';
import 'package:challenge_two/app/my_app_controller.dart';
import 'package:challenge_two/core/data/repositories/shared_preferences_repository.dart';
import 'package:challenge_two/core/enums/connectivity_status.dart';
import 'package:challenge_two/core/enums/message_type.dart';
import 'package:challenge_two/core/services/cart_service.dart';
import 'package:challenge_two/core/services/connectivity_service.dart';
import 'package:challenge_two/core/services/location_service.dart';
import 'package:challenge_two/core/services/notification_service.dart';
import 'package:challenge_two/core/translation/app_translation.dart';
import 'package:challenge_two/core/utils/network_utils.dart';
import 'package:challenge_two/ui/shared/colors.dart';
import 'package:challenge_two/ui/shared/custom_widgets/custom_button.dart';
import 'package:challenge_two/ui/shared/custom_widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

bool isVaildEmail(String value) {
  RegExp regExp = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  return regExp.hasMatch(value);
}

// 1 uppercase
// 1 special char [!@#\$&*~]
// min 8 char length

bool isVaildPassword(String value) {
  RegExp regExp = new RegExp(r'^(?=.*?[A-Z])(?=.*?[!@#\$&*~]).{8,}$');
  return regExp.hasMatch(value);
}

// ^ - Start of string
// \+? - Match + ( optional )
// 09 - Match literally 09
// [0-9]{9} - Match any digits between 0 to 9, 9 times
// $ -End of string

bool isVaildMobileNo(String value) {
  RegExp regExp = new RegExp(r'^\+?09[0-9]{8}$');
  return regExp.hasMatch(value);
}

bool isValidSyriaMobileNo(String mobileNumber) {
  RegExp regex = RegExp(r'^(!?(\+|00)?(963)|0)?9\d{8}$');
  return regex.hasMatch(mobileNumber);
}

bool isVaildName(String value) {
  RegExp regExp = new RegExp(r"^[a-zA-Z]+(([\'\-\s][a-zA-Z])?[a-zA-Z]*)*$");
  return regExp.hasMatch(value);
}

String getFullImageUrl(String url) {
  var splitedString = url.split('Images/');
  return 'https://${NetworkUtil.baseUrl}/Images/${splitedString[1]}';
}

// Size get globalSize => MediaQuery.of(globalContext!).size;

double screenWidth(double percent) {
  if (GetPlatform.isMobile) {
    return Get.width / percent;
  } else
    return Get.height / percent;
}

double screenHeight(double percent) {
  if (GetPlatform.isMobile) {
    return Get.height / percent;
  } else
    return Get.width / percent;
}

SharedPreferencesRepository get storage =>
    Get.find<SharedPreferencesRepository>();

CartService get cartService => Get.find<CartService>();
ConnectivityService get connectivityService => Get.find<ConnectivityService>();
LocationService get locationService => Get.find<LocationService>();
NotificationService get notificationService => Get.find<NotificationService>();

void customLoader() => BotToast.showCustomLoading(
        // duration: Duration(seconds: 10),
        toastBuilder: (context) {
      return Container(
        width: screenWidth(3),
        height: screenWidth(3),
        decoration: BoxDecoration(
          color: AppColors.placeholderGreyColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: SpinKitCircle(
          color: AppColors.mainBlueColor,
        ),
      );
    });

double get taxAmount => 0.18;
double get deliveryFeesAmount => 0.1;

bool get isOnline =>
    Get.find<MyAppController>().connectivityStatus == ConnectivityStatus.ONLINE;

bool get isOffline =>
    Get.find<MyAppController>().connectivityStatus ==
    ConnectivityStatus.OFFLINE;

void checkConnection(Function function) {
  if (isOnline)
    function();
  else
    showNoConnectionMessage();
}

void showNoConnectionMessage() {
  CustomToast.showMessage(
    message: 'Please check internet connection',
    messageType: MessageType.WARNING,
  );
}

void showAlertDialoug({
  String? title,
  required String? middleText,
  required Function? onCancel,
  required Function? onConfirm,
}) {
  Get.defaultDialog(
    title: title ?? "",
    middleText: middleText ?? "",
    cancel: CustomButton(
      onPressed: () {
        if (onCancel != null) onCancel();
      },
      width: screenWidth(3),
      text: tr("key_no"),
      backgroundColor: AppColors.mainRedColor,
    ),
    confirm: CustomButton(
      onPressed: () {
        if (onConfirm != null) onConfirm();
      },
      width: screenWidth(3),
      text: tr("key_yes"),
    ),
    onCancel: () {}, onConfirm: () {},

    // content:
  );
  // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
}
