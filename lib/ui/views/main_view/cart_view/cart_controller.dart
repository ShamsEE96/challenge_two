import 'package:challenge_two/core/data/models/cart_model.dart';
import 'package:challenge_two/core/services/base_controller.dart';
import 'package:challenge_two/ui/shared/utils.dart';
import 'package:challenge_two/ui/views/checkout_view/checkout_view.dart';
import 'package:get/get.dart';

class CartController extends BaseController {
  RxList<CartModel> cartList = cartService.cartList;
  @override
  void onInit() {
    super.onInit();
  }

  void removeFromCartList(CartModel cartModel) {
    cartService.removeFromCartList(
      cartModel: cartModel,
    );
  }

  void changeCount({
    required bool increase,
    required CartModel cartModel,
  }) {
    cartService.changeMealCount(
      increase: increase,
      cartModel: cartModel,
    );
  }

  void checkout() {
    runFutureFunctionWithFullLoading(
      function: Future.delayed(
        Duration(seconds: 2),
      ),
    ).then((value) {
      Get.off(() => CheckoutView());
    });
  }
}
