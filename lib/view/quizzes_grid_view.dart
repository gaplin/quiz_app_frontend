import 'package:flutter/material.dart';

import '../components/quiz_card.dart';
import '../model/quiz.dart';

class QuizzesGridView extends StatelessWidget {
  final Future<List<Quiz>> quizzes;

  const QuizzesGridView({
    super.key,
    required this.quizzes,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Quiz>>(
      future: quizzes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _QuizzesGrid(
            quizzes: snapshot.data!,
          );
        } else if (snapshot.hasError) {
          return Text("Error");
        }
        return Text("");
      },
    );
  }
}

class _QuizzesGrid extends StatelessWidget {
  final List<Quiz> quizzes;
  const _QuizzesGrid({
    required this.quizzes,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: quizzes.length,
      itemBuilder: (context, index) {
        return QuizCard(quiz: quizzes[index]);
      },
    );
  }
}
