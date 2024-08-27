import 'package:flutter/widgets.dart';
import 'package:frontend/app_config.dart';

class BaseAPI {
  BuildContext context;

  BaseAPI(this.context);
  
  AppConfig get config => AppConfig.of(context)!;

  String get base => config.baseUrl ;
  String get apiUrl => "$base/api";
  String get diagnosticScreenerAnswersPath => "$apiUrl/diagnostic_screener_answers";

  Map<String,String> get headers => {                           
    "Content-Type": "application/json; charset=UTF-8" 
  };
}