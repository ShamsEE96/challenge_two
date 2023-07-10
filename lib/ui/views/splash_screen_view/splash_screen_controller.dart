import 'package:challenge_two/core/services/base_controller.dart';
import 'package:challenge_two/ui/shared/utils.dart';
import 'package:get/get.dart';

class SplashScreenController extends BaseController {
  @override
  void onInit() {
    if (storage.getOrderPlaced()) {
      cartService.clearCart();
      storage.setOrderPlaced(false);
    }
    Future.delayed(
      Duration(seconds: 4),
    ).then(
      (value) {
        if (storage.getFirstLaunch() && storage.getTokenInfo() == null) {
          // Get.off(() => IntroView());
        } else
          // Get.off(
          //   () => storage.isLoggedIn ? MainView() : LandingView(),
          // );

          storage.setFirstLaunch(false);
      },
    );
    super.onInit();
  }
}
