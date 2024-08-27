import 'dart:async';
import 'dart:convert';
import 'package:frontend/api/diagnostic_screener.dart';
import 'package:frontend/models/diagnostic_screener.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';


class HomeController extends GetxController {
  late TextEditingController locationController;
  late ScrollController infiniteScrollController;
  List address = [];

  final BuildContext context;
  HomeController(this.context);

  @override
  void onInit() {
    locationController = TextEditingController();
    infiniteScrollController = ScrollController();
    super.onInit();
  }

  @override
  void dispose() {
    locationController.dispose();
    infiniteScrollController.dispose();
    super.dispose();
  }

  getDiagnosticScreener() async {
    final DiagnosticScreenerAPI _diagnosticScreenerAPI = DiagnosticScreenerAPI(context);
    var _diagnosticScreener = await _diagnosticScreenerAPI.getDiagnosticScreener();
    if (_diagnosticScreener.statusCode == 200) {
      final DiagnosticScreener diagnosticScreener = DiagnosticScreener.fromReqBody(jsonDecode(_diagnosticScreener.body));
      return diagnosticScreener;
    } else {
      throw Exception('Failed to load data');
    }
  }

  submitDiagnosticScreener(List answers) async {
    final DiagnosticScreenerAPI _diagnosticScreenerAPI = DiagnosticScreenerAPI(context);
    var assessmentResults = await _diagnosticScreenerAPI.submitDiagnosticScreener(answers);
    if (assessmentResults.statusCode == 200) {
      return jsonDecode(assessmentResults.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}