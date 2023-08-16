import 'package:challenge_two/core/data/models/apis/product_model.dart';
import 'package:challenge_two/core/enums/message_type.dart';
import 'package:challenge_two/core/services/base_controller.dart';
import 'package:challenge_two/ui/shared/custom_widgets/custom_toast.dart';
import 'package:challenge_two/ui/shared/utils.dart';
import 'package:challenge_two/ui/views/main_view/cart_view/cart_view.dart';
import 'package:get/get.dart';

class ProductDetailsController extends BaseController {
  ProductDetailsController({required ProductModel productModel}) {
    model = productModel;
  }

  RxInt count = 1.obs;

  ProductModel model = ProductModel();

  void changeCount(bool increase) {
    if (increase)
      count++;
    else {
      if (count > 1) {
        count--;
      }
    }
  }

  double calcTotal() {
    return cartService.calcProductTotal(
      productModel: model,
      count: count.value,
    );
  }

  void addToCart() {
    cartService.addToCartList(
      productModel: model,
      count: count.value,
      afterAdd: () {
        CustomToast.showMessage(
          message: 'Item Added to Cart',
          messageType: MessageType.SUCCESS,
        );
        Get.back();
      },
    );
  }
}
