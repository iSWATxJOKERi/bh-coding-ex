import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:frontend/api/base.dart';
import 'package:http/http.dart' as http;

class DiagnosticScreenerAPI extends BaseAPI {
  final BuildContext context;
  DiagnosticScreenerAPI(this.context) : super(context);

  Future<http.Response> getDiagnosticScreener() async {
    http.Response response = await http.get(Uri.parse("$diagnosticScreenerAnswersPath/get_diagnostic_screener"));

    return response;
  }

  Future<http.Response> submitDiagnosticScreener(answers) async {
    var body = jsonEncode({
      'answers': answers
    });

    http.Response response = await http.post(Uri.parse(diagnosticScreenerAnswersPath), headers: headers, body: body);

    return response;
  }
}