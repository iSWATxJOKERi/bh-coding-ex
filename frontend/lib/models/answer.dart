class Answer {
  final String title;
  final int value;

  Answer({ 
    required this.title,
    required this.value
  });

  factory Answer.fromReqBody(json) {
    Map body = json;

    return Answer(
      title: body["title"],
      value: body["value"]
    );
  }
}