import 'package:flutter/material.dart';
import 'package:frontend/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  final BuildContext context;
  HomeBinding(this.context);

  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(context));
  }
}