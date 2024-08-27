import 'package:flutter/widgets.dart';
import 'package:frontend/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding implements Bindings {
  final BuildContext context;
  SplashBinding(this.context);

  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController(context));
  }
}