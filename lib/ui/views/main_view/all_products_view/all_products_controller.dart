import 'package:challenge_two/core/data/models/apis/product_model.dart';
import 'package:challenge_two/core/data/repositories/product_repository.dart';
import 'package:challenge_two/core/enums/message_type.dart';
import 'package:challenge_two/core/enums/operation_type.dart';
import 'package:challenge_two/core/enums/request_status.dart';
import 'package:challenge_two/core/services/base_controller.dart';
import 'package:challenge_two/ui/shared/custom_widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProductsController extends BaseController {
  TextEditingController searchController = TextEditingController();

  RxList<ProductModel> productlList = <ProductModel>[].obs;
  RxList<ProductModel> resultList = <ProductModel>[].obs;

  bool get isProductLoading =>
      requestStatus == RequestStatus.LOADING &&
      operationTypeList.contains(OperationType.PRODUCT);

  @override
  void onInit() {
    getAllProduct();

    super.onInit();
  }

  void filterSearchResults({String? query}) {
    // resultList.clear();
    resultList.value = productlList
        .where(
            (item) => item.title!.toLowerCase().contains(query!.toLowerCase()))
        .toList();
    if (resultList.isEmpty) {
      FocusManager.instance.primaryFocus?.unfocus();
      CustomToast.showMessage(
        message: "No Results found",
        messageType: MessageType.WARNING,
      );
    }
  }

  void getAllProduct() {
    runFutureFunctionWithLoading(
      operationType: OperationType.PRODUCT,
      function: ProductRepository().getAllProducts().then(
        (value) {
          value.fold(
            (l) {
              CustomToast.showMessage(
                message: l,
                messageType: MessageType.REJECTED,
              );
            },
            (r) {
              // mealList.clear();
              productlList.addAll(r);
            },
          );
        },
      ),
    );
  }
}
