import 'package:flutter/widgets.dart';

class AppConfig extends InheritedWidget{
  final String appName;
  final String flavor;
  final String baseUrl;

  const AppConfig({
    required this.appName, 
    required this.flavor,
    required this.baseUrl,
    required Widget child,
    super.key
  }) : super(child: child);

  static AppConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }

  @override
  bool updateShouldNotify(AppConfig oldWidget) => false;
}