class Question {
  final String title, questionId;

  Question({
    required this.title,
    required this.questionId
  });

  factory Question.fromReqBody(json) {
    Map body = json;

    return Question(
      title: body["title"],
      questionId: body["question_id"]
    );
  }
}