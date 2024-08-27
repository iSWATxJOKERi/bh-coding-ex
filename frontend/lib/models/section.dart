import 'package:frontend/models/answer.dart';
import 'package:frontend/models/question.dart';

class Section {
  final String type, title;
  final List<Answer> answers;
  final List<Question> questions;

  Section({ 
    required this.type,
    required this.title,
    required this.answers,
    required this.questions
  });

  factory Section.fromReqBody(json) {
    Map body = json;

    return Section(
      title: body['title'],
      type: body['type'],
      answers: [for (var answer in body["answers"]) Answer.fromReqBody(answer)],
      questions: [for (var question in body["questions"]) Question.fromReqBody(question)]
    );
  }
}