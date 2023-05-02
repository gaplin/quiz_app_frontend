import 'package:flutter/material.dart';

import '../api_client/rest_client.dart';
import '../components/question_list_view.dart';
import '../components/title_card.dart';
import '../model/quiz.dart';

class QuizPage extends StatefulWidget {
  final String quizId;

  const QuizPage({super.key, required this.quizId});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final RestClient client = RestClient();
  var questionIndex = 0;
  late Future<Quiz> quiz;
  var score = 0;
  callback(bool correctAnswer) {
    setState(() {
      if (correctAnswer) score += 1;
      questionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimaryContainer,
    );
    return FutureBuilder<Quiz>(
      future: quiz,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Quiz quiz = snapshot.data!;
          if (questionIndex < quiz.questions.length) {
            return Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 50),
                  Center(
                    child: Text(
                      quiz.title,
                      style: style,
                    ),
                  ),
                  SizedBox(height: 100),
                  Flexible(
                    child: SizedBox(
                      width: 900,
                      child: QuestionListView(
                        question: quiz.questions[questionIndex],
                        callBack: callback,
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Placeholder();
          }
        } else if (snapshot.hasError) {
          return Text("Error");
        }
        return Text("");
      },
    );
  }

  @override
  void initState() {
    super.initState();
    quiz = client.getShuffledQuizById(widget.quizId);
  }
}
