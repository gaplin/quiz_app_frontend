import 'package:flutter/material.dart';

import 'quiz_card.dart';
import '../model/quiz_base.dart';

class QuizzesGrid extends StatefulWidget {
  final List<QuizBase> quizzes;
  const QuizzesGrid({
    super.key,
    required this.quizzes,
  });

  @override
  State<QuizzesGrid> createState() => _QuizzesGridState();
}

class _QuizzesGridState extends State<QuizzesGrid> {
  quizDeletedCallback(String quizId) {
    setState(() {
      widget.quizzes.removeWhere((element) => element.id == quizId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: widget.quizzes.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: QuizCard(
            quiz: widget.quizzes[index],
            quizDeletedCallback: quizDeletedCallback,
          ),
        );
      },
    );
  }
}
