import 'package:frontend/models/section.dart';

class Content {
  final String displayName;
  final List<Section> sections;

  Content({ 
    required this.displayName,
    required this.sections
  });

  factory Content.fromReqBody(json) {
    Map body = json;

    return Content(
      displayName: body["display_name"],
      sections: [for (var section in body["sections"]) Section.fromReqBody(section)],
    );
  }
}