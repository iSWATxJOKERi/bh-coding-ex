import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/home_controller.dart';
import 'package:frontend/models/answer.dart';
import 'package:frontend/models/diagnostic_screener.dart';
import 'package:frontend/models/question_and_answer.dart';
import 'package:frontend/utils/notifiers.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController controller = Get.find();
  final ValueNotifier<bool> dataFetched = ValueNotifier(false);
  late DiagnosticScreener diagnosticScreener;
  late DiagnosticScreenerService diagnosticScreenerService;

  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  void fetchInitialData() async {
    diagnosticScreener = await controller.getDiagnosticScreener();
    diagnosticScreenerService = DiagnosticScreenerService();
    diagnosticScreenerService.constructScreen(diagnosticScreener.content.sections[0].questions);
    dataFetched.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: dataFetched,
      builder: (BuildContext context, bool dataFetchedValue, Widget? _) {
        if(dataFetchedValue) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                diagnosticScreener.fullName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: "Monteserrat",
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    diagnosticScreener.content.displayName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      fontFamily: "Monteserrat",
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    diagnosticScreener.content.sections[0].title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      fontFamily: "Monteserrat",
                    ),
                  ),
                  const SizedBox(height: 15),
                  ListenableBuilder(
                    listenable: diagnosticScreenerService,
                    builder: (BuildContext context, Widget? child) {
                      if(diagnosticScreenerService.screenFininshed) {
                        return const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Blueprint Diagnostic Screener completed",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: "Monteserrat",
                              ),
                            ),
                          ],
                        );
                      } else {
                        QuestionAndAnswer currentQuestion = diagnosticScreenerService.currentQuestion!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Question: ${currentQuestion.question.title}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: "Monteserrat",
                              ),
                            ),
                            const SizedBox(height: 10),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                List<Answer> answers = diagnosticScreener.content.sections[0].answers;
                                return ListTile(
                                  title: Text(
                                    answers[index].title,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: "Monteserrat",
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  onTap: () async {
                                    diagnosticScreenerService.updateAnswerToQuestion(answers[index]);
                                    if(diagnosticScreenerService.screenFininshed) {
                                      List answers = diagnosticScreenerService.convertAnswersToJson();
                                      var results = await controller.submitDiagnosticScreener(answers);
                                      print(results);
                                    }
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: 60),
                            LinearProgressIndicator(
                              value: diagnosticScreenerService.progress,
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${diagnosticScreenerService.questionsCompleted} out of ${diagnosticScreenerService.questionCount} questions  completed",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: "Monteserrat",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                    }
                  )
                ],
              ),
            )
          );
        } else {
          return const Center(
            child: SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
          ); 
        }
      }
    );
  }
}
