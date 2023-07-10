import 'package:challenge_two/core/data/models/apis/meal_model.dart';
import 'package:challenge_two/core/data/models/cart_model.dart';
import 'package:get/get.dart';

import '../../ui/shared/utils.dart';

class CartService {
  RxList<CartModel> cartList = storage.getCartList().obs;

  RxInt cartCount = 0.obs;

  RxDouble subTotal = 0.0.obs;
  RxDouble tax = 0.0.obs;
  RxDouble deliverFees = 0.0.obs;
  RxDouble total = 0.0.obs;

  CartService() {
    getCartCount();
    calcCartTotal();
  }

  CartModel? getCartModel(MealModel mealModel) {
    try {
      return cartList.firstWhere(
        (element) => element.mealModel!.id == mealModel.id,
      );
    } catch (e) {
      return null;
    }
  }

  int getIndex(CartModel cartModel) => cartList.indexOf(cartModel);

  int getCartCount() {
    cartCount.value = cartList.fold(
      0,
      (previousValue, element) => previousValue + element.count!,
    );
    return cartCount.value;
  }

  double calcMealTotal({
    required MealModel mealModel,
    required int count,
  }) {
    return (mealModel.price! * count).toDouble();
  }

  void calcCartTotal() {
    // subTotal.value = 0.0;
    // tax.value = 0.0;
    // deliverFees.value = 0.0;
    // total.value = 0.0;

    subTotal.value = cartList.fold(
        0, (previousValue, element) => previousValue + element.total!);
    tax.value = subTotal.value * taxAmount;
    deliverFees.value = (subTotal.value + tax.value) * deliveryFeesAmount;
    total.value = subTotal.value + deliverFees.value + tax.value;
  }

// //!---- Check if Meal Exist in Cart List ----
//   bool isMealExist({
//     required MealModel mealModel,
//   }) {
//     CartModel? result = cartList.firstWhere(
//       (element) {
//         return element.mealModel!.id == mealModel.id;
//       },
//       orElse: () {
//         return CartModel();
//       },
//     );
//     return result.count != null;
//   }

// //!---- Get Cart Item Index ----
//   int getIndex({
//     required CartModel cartModel,
//   }) {
//     if (isMealExist(
//       mealModel: cartModel.mealModel!,
//     )) {
//       int index = cartList.indexOf(cartModel);
//       return index;
//     } else
//       return -1;
//   }

//!---- Add Item to Cart ----
  void addToCartList({
    required MealModel mealModel,
    required int count,
    Function? afterAdd,
  }) {
    double mealTotal = calcMealTotal(count: count, mealModel: mealModel);
    if (getCartModel(mealModel) != null) {
      int index = getIndex(getCartModel(mealModel)!);
      cartList[index].count = cartList[index].count! + count;
      cartList[index].total = cartList[index].total! + mealTotal;
    } else {
      cartList.add(
        CartModel(
          count: count,
          total: mealTotal,
          mealModel: mealModel,
        ),
      );
    }
    storage.setCartList(cartList);
    cartCount.value += count;
    if (afterAdd != null) afterAdd();

    calcCartTotal();
  }

  void removeFromCartList({
    required CartModel cartModel,
    Function? afterRemove,
  }) {
    cartList.remove(cartModel);
    cartCount.value -= cartModel.count!;
    storage.setCartList(cartList);
    if (afterRemove != null) afterRemove();
    calcCartTotal();
  }

  void changeMealCount({
    required bool increase,
    required CartModel cartModel,
    Function? afterChange,
  }) {
    CartModel? result = getCartModel(cartModel.mealModel!)!;
    int index = getIndex(result);
    // double mealTotal =
    //     calcMealTotal(mealModel: result.mealModel!, count: result.count!);

    if (increase) {
      result.count = result.count! + 1;
      result.total = result.total! + cartModel.mealModel!.price!;
      cartCount.value += 1;
      calcCartTotal();
    } else {
      if (result.count! > 1) {
        result.count = result.count! - 1;
        result.total = result.total! - cartModel.mealModel!.price!;
        cartCount.value -= 1;
        calcCartTotal();
      }
    }
    cartList.remove(result);
    cartList.insert(index, result);

    storage.setCartList(cartList);
    if (afterChange != null) afterChange();
  }

  void clearCart() {
    cartList.clear();
    storage.setCartList(cartList);
    cartCount.value = getCartCount();
    calcCartTotal();
  }
}
