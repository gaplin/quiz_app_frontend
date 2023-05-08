import 'package:flutter/material.dart';
import 'package:quiz_app_frontend/components/custom_app_bar.dart';
import 'package:quiz_app_frontend/components/title_card.dart';
import 'package:quiz_app_frontend/pages/quiz_page.dart';
import 'package:quiz_app_frontend/pages/quizzes_page.dart';

import '../model/quiz.dart';

class EndQuizPage extends StatelessWidget {
  final int correctAnswers;
  final Quiz quiz;

  const EndQuizPage({
    super.key,
    required this.correctAnswers,
    required this.quiz,
  });

  @override
  Widget build(BuildContext context) {
    final int allAnswers = quiz.questions.length;
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimaryContainer,
    );
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              Center(
                child: Text(
                  quiz.title,
                  style: style,
                ),
              ),
              SizedBox(height: 100),
              SizedBox(
                width: 700,
                child: TitleCard(
                  title: "Your score: $correctAnswers / $allAnswers",
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      var nav = Navigator.of(context);
                      nav.pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => QuizzesPage(),
                        ),
                      );
                    },
                    child: Text('Go back to home screen'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      var nav = Navigator.of(context);
                      nav.pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => QuizPage(quizId: quiz.id),
                        ),
                      );
                    },
                    child: Text('Try again'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
