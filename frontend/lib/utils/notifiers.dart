import 'package:flutter/material.dart';
import 'package:frontend/models/answer.dart';
import 'package:frontend/models/question.dart';
import 'package:frontend/models/question_and_answer.dart';

class DiagnosticScreenerService extends ChangeNotifier {
  QuestionAndAnswer? _firstQuestion;
  QuestionAndAnswer? get firstQuestion => _firstQuestion;
  QuestionAndAnswer? _lastQuestion;
  QuestionAndAnswer? get lastQuestion => _lastQuestion;
  QuestionAndAnswer? _currentQuestion;
  QuestionAndAnswer? get currentQuestion => _currentQuestion;

  int _questionCount = 0;
  int get questionCount => _questionCount;

  bool _screenFinished = false;
  bool get screenFininshed => _screenFinished;

  final Set _completedQuestions = {};
  int get questionsCompleted => _completedQuestions.length;

  double get progress => (_completedQuestions.isNotEmpty) ? (questionsCompleted / questionCount).toDouble() : 0.0;

  void constructScreen(List questions) {    
    questions = questions.reversed.toList();
    _questionCount = questions.length;
    while(questions.isNotEmpty) {
      Question question = questions.removeLast();
      QuestionAndAnswer questionAndAnswer = QuestionAndAnswer.fromBody(question);
      if(firstQuestion == null) {
        _firstQuestion = questionAndAnswer;
      } else {
        lastQuestion!.nextQuestion = questionAndAnswer;
      }
      _lastQuestion = questionAndAnswer;
    }
    _currentQuestion = firstQuestion;
  }

  void updateAnswerToQuestion(Answer answer) {
    _currentQuestion!.answer = answer;
    _completedQuestions.add(_currentQuestion!.question.questionId);
    if(_currentQuestion!.nextQuestion != null) {
      _currentQuestion = _currentQuestion!.nextQuestion;
      notifyListeners();
    } else {
      if(allQuestionsAnswered()) {
        _screenFinished = true;
        notifyListeners();
      }
    }
  }

  bool allQuestionsAnswered() {
    return _completedQuestions.length == _questionCount;
  }

  List convertAnswersToJson() {
    List answers = [];
    
    QuestionAndAnswer questionAndAnswer = firstQuestion!;

    while(questionAndAnswer.nextQuestion != null) {
      answers.add({
        "value": questionAndAnswer.answer!.value,
        "question_id": questionAndAnswer.question.questionId
      });
      questionAndAnswer = questionAndAnswer.nextQuestion!;
    }
    
    answers.add({
      "value": questionAndAnswer.answer!.value,
      "question_id": questionAndAnswer.question.questionId
    });

    return answers;
  }
}