import 'package:challenge_two/app/my_app.dart';
import 'package:challenge_two/app/my_app_controller.dart';
import 'package:challenge_two/core/data/repositories/shared_preferences_repository.dart';
import 'package:challenge_two/core/services/cart_service.dart';
import 'package:challenge_two/core/services/connectivity_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync<SharedPreferences>(() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  });
  await Get.put(SharedPreferencesRepository());
  Get.put(CartService());
  Get.put(ConnectivityService());
  Get.put(MyAppController());
  runApp(const MyApp());
}
