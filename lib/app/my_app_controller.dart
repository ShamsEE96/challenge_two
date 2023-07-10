import 'package:challenge_two/core/enums/connectivity_status.dart';
import 'package:challenge_two/core/services/base_controller.dart';
import 'package:challenge_two/ui/shared/utils.dart';
import 'package:get/get.dart';

class MyAppController extends BaseController {
  Rx<ConnectivityStatus> connectivityStatus = ConnectivityStatus.ONLINE.obs;

  set setConnectivityStatus(ConnectivityStatus value) {
    connectivityStatus.value = value;
  }

  void listenForConnectivityStatus() {
    connectivityService.connectivityStatusController.stream.listen((event) {
      setConnectivityStatus = event;
    });
  }

  @override
  void onInit() {
    listenForConnectivityStatus();
    super.onInit();
  }
}
