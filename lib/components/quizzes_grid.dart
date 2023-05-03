import 'package:flutter/material.dart';

import 'quiz_card.dart';
import '../model/quiz_base.dart';

class QuizzesGrid extends StatelessWidget {
  final List<QuizBase> quizzes;
  const QuizzesGrid({
    super.key,
    required this.quizzes,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: quizzes.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: QuizCard(quiz: quizzes[index]),
        );
      },
    );
  }
}
