import 'package:flutter/material.dart';
import 'package:frontend/splash/splash_controller.dart';
import 'package:get/get.dart';


class Splash extends StatelessWidget {
  const Splash({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text(
           "BH",
            style: TextStyle(
              color: Colors.black,
              fontSize: 36,
              fontFamily: "Monteserrat",
            ), 
          )
        ),
      )
    );
  }
}