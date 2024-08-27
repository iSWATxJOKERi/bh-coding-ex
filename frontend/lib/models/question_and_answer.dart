import 'package:frontend/models/answer.dart';
import 'package:frontend/models/question.dart';

class QuestionAndAnswer {
  final Question question;
  Answer? answer;
  QuestionAndAnswer? previousQuestion;
  QuestionAndAnswer? nextQuestion;

  QuestionAndAnswer({
    required this.question,
    this.answer,
    this.previousQuestion,
    this.nextQuestion
  });

  factory QuestionAndAnswer.fromBody(question) {
    return QuestionAndAnswer(
      question: question
    );
  }
}