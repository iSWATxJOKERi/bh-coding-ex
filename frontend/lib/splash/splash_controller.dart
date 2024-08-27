import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final BuildContext context;
  SplashController(this.context);

  @override
  void onReady() {
    super.onReady();
      Future.delayed(const Duration(milliseconds: 2500), () {
        Get.offAllNamed('/home');
      });
  }
}