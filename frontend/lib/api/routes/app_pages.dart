import 'package:frontend/api/routes/app_routes.dart';
import 'package:frontend/home.dart';
import 'package:frontend/home_binding.dart';
import 'package:frontend/splash/splash_binding.dart';
import 'package:frontend/splash/splash_view.dart';
import 'package:get/get.dart';

class AppPages {
  static getPages(context) {
    return [
      GetPage(
        name: AppRoutes.splash,
        page: () => Splash(),
        binding: SplashBinding(context),
      ),
      GetPage(
        name: AppRoutes.home,
        page: () => Home(),
        binding: HomeBinding(context),
      ),
    ];
  }
}