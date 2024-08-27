import 'package:flutter/material.dart';
import 'package:frontend/app_config.dart';
import 'package:frontend/splash/splash_binding.dart';
import 'package:get/get.dart';
import 'package:frontend/api/routes/app_pages.dart';
import 'package:frontend/api/routes/app_routes.dart';

class BH extends StatelessWidget {
  const BH({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var config = AppConfig.of(context)!;

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: config.appName,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: false
      ),
      initialBinding: SplashBinding(context),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.getPages(context),
    );
  }
}