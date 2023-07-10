import 'package:bot_toast/bot_toast.dart';
import 'package:challenge_two/core/enums/operation_type.dart';
import 'package:challenge_two/core/enums/request_status.dart';
import 'package:challenge_two/ui/shared/utils.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  var requestStatus = RequestStatus.DEFAULT.obs;
  // var operationType = OperationType.NONE.obs;
  RxList<OperationType> operationTypeList = <OperationType>[].obs;

  bool get isLoading =>
      requestStatus == RequestStatus.LOADING &&
      operationTypeList.contains(OperationType.NONE);

  set setRequestStatus(RequestStatus value) {
    requestStatus.value = value;
  }

  // set setOperationType(OperationType value) {
  //   operationType.value = value;
  // }

  Future runFutureFunction({
    required Future function,
  }) async {
    checkConnection(
      () async {
        await function;
      },
    );
  }

  Future runFutureFunctionWithLoading({
    required Future function,
    OperationType? operationType = OperationType.NONE,
  }) async {
    checkConnection(
      () async {
        setRequestStatus = RequestStatus.LOADING;
        operationTypeList.add(operationType!);
        // setOperationType = operationType!;
        await function;
        setRequestStatus = RequestStatus.DEFAULT;
        operationTypeList.remove(operationType);
        // setOperationType = OperationType.NONE;
      },
    );
  }

  Future runFutureFunctionWithFullLoading({
    required Future function,
    OperationType? operationType = OperationType.NONE,
  }) async {
    checkConnection(
      () async {
        customLoader();
        await function;
        BotToast.closeAllLoading();
      },
    );
  }
}
