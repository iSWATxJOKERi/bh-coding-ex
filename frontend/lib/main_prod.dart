import 'package:flutter/material.dart';
import 'package:frontend/app_config.dart';
import 'package:frontend/main.dart';

void main() async {
  var configuredApp = const AppConfig(
    appName: 'bh-dev',
    flavor: 'dev',
    baseUrl: 'http://ec2-18-235-169-134.compute-1.amazonaws.com:3000',
    child: BH()
  );
	runApp(configuredApp);
}