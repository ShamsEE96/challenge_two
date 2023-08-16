import 'package:challenge_two/core/data/models/apis/product_model.dart';
import 'package:challenge_two/core/data/repositories/product_repository.dart';
import 'package:challenge_two/core/enums/message_type.dart';
import 'package:challenge_two/core/enums/operation_type.dart';
import 'package:challenge_two/core/enums/request_status.dart';
import 'package:challenge_two/core/services/base_controller.dart';
import 'package:challenge_two/ui/shared/custom_widgets/custom_toast.dart';
import 'package:get/get.dart';

class HomeController extends BaseController {
  RxList<String> categoryList = <String>[].obs;
  RxList<ProductModel> productlList = <ProductModel>[].obs;

  RxString selectedCategory = "All".obs;

  // RxInt currentIndex = 0.obs;

  bool get isCategoryLoading =>
      requestStatus == RequestStatus.LOADING &&
      operationTypeList.contains(OperationType.CATEGORY);

  bool get isProductLoading =>
      requestStatus == RequestStatus.LOADING &&
      operationTypeList.contains(OperationType.PRODUCT);

  @override
  void onInit() {
    getAllCategory();
    getAllProduct();

    super.onInit();
  }

  void getAllCategory() {
    runFutureFunctionWithLoading(
      operationType: OperationType.CATEGORY,
      function: ProductRepository().getAllCategories().then(
        (value) {
          value.fold(
            (l) {
              CustomToast.showMessage(
                message: l,
                messageType: MessageType.REJECTED,
              );
            },
            (r) {
              // categoryList.clear();
              categoryList.addAll(r);
            },
          );
        },
      ),
    );
    getProductByCategory(categoryName: selectedCategory.value);
  }

  void getProductByCategory({
    required String categoryName,
    // int? currentIndex,
  }) {
    selectedCategory.value = categoryName;
    if (selectedCategory.value == "All") {
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
                productlList.clear();
                productlList.addAll(r);
              },
            );
          },
        ),
      );
    } else {
      runFutureFunctionWithLoading(
        operationType: OperationType.PRODUCT,
        function: ProductRepository()
            .getProductByCategory(categoryName: categoryName)
            .then(
          (value) {
            value.fold(
              (l) {
                CustomToast.showMessage(
                  message: l,
                  messageType: MessageType.REJECTED,
                );
              },
              (r) {
                productlList.clear();
                productlList.addAll(r);
              },
            );
          },
        ),
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
