import 'package:frontend/models/content.dart';

class DiagnosticScreener {
  final String id, name, disorder, fullName;
  final Content content;

  DiagnosticScreener({ 
    required this.id,
    required this.name,
    required this.disorder,
    required this.content,
    required this.fullName
  });

  factory DiagnosticScreener.fromReqBody(json) {
    Map body = json;

    return DiagnosticScreener(
      id: body['id'],
      name: body['name'],
      disorder: body['disorder'],
      content: Content.fromReqBody(body['content']),
      fullName: body["full_name"]
    );
  }
}