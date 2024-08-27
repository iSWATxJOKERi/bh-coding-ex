import 'package:flutter/material.dart';
import 'package:frontend/app_config.dart';
import 'package:frontend/main.dart';

void main() async {
  var configuredApp = const AppConfig(
    appName: 'bh-dev',
    flavor: 'dev',
    baseUrl: 'http://127.0.0.1:3000',
    child: BH()
  );
	runApp(configuredApp);
}