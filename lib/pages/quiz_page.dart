import 'package:flutter/material.dart';
import 'package:quiz_app_frontend/components/custom_app_bar.dart';
import 'package:quiz_app_frontend/pages/end_quiz_page.dart';

import '../api_client/rest_client.dart';
import '../components/question_list_view.dart';
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
    final titleStyle = theme.textTheme.headlineSmall!.copyWith(
      color: theme.colorScheme.onPrimaryContainer,
    );
    final bodyStyle = theme.textTheme.labelLarge!
        .copyWith(color: theme.colorScheme.onPrimaryContainer);
    return FutureBuilder<Quiz>(
      future: quiz,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Quiz quiz = snapshot.data!;
          if (questionIndex < quiz.questions.length) {
            return Scaffold(
              appBar: CustomAppBar(),
              body: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        quiz.title,
                        style: titleStyle,
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        'Question ${questionIndex + 1} of ${quiz.questions.length}',
                        style: bodyStyle,
                      ),
                    ),
                    SizedBox(height: 10),
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
              ),
            );
          } else {
            return EndQuizPage(
              correctAnswers: score,
              quiz: quiz,
            );
          }
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
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
