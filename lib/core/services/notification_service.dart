import 'dart:async';

import 'package:challenge_two/core/data/models/notification_model.dart';
import 'package:challenge_two/core/enums/app_state.dart';
import 'package:challenge_two/core/enums/notification_type.dart';
import 'package:challenge_two/ui/shared/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/utils.dart';

class NotificationService {
  StreamController<NotificationModel> notifcationStream =
      StreamController<NotificationModel>.broadcast();

  NotificationService() {
    onInit();
  }

  void onInit() async {
    if (GetPlatform.isIOS) {
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        await registerdFCMToken();
      } else {
        return;
      }
    } else {
      await registerdFCMToken();
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationModel model = NotificationModel.fromJson(message.data);
      handelNotification(model: model, appState: AppState.FOREGROUND);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      NotificationModel model = NotificationModel.fromJson(message.data);
      handelNotification(model: model, appState: AppState.BACKGROUND);
    });
  }

  Future<void> registerdFCMToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    //! -- Call api that register fcm token ---

    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      //! -- Call api that register fcm token ---
      // TODO: If necessary send token to application server.

      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
    }).onError((err) {
      // Error getting token.
    });
  }

  void handelNotification(
      {required NotificationModel model, required AppState appState}) {
    notifcationStream.add(model);
    if (model.notifctionType == NotificationType.SUBSCRIPTION.name) {
      storage.setSubStatus(model.subStatus == "1" ? true : false);
    }
  }
}
