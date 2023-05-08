import 'package:flutter/material.dart';

import '../model/quiz_base.dart';
import '../pages/quiz_page.dart';

class QuizCard extends StatelessWidget {
  const QuizCard({
    super.key,
    required this.quiz,
  });

  final QuizBase quiz;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.titleLarge!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Container(
      constraints: BoxConstraints(minWidth: 500, minHeight: 500),
      child: Card(
        color: theme.colorScheme.primary,
        child: InkWell(
          onTap: () => {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => QuizPage(quizId: quiz.id),
              ),
            ),
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Text(
                  quiz.title,
                  style: titleStyle,
                ),
                SizedBox(height: 50),
                Text(
                  '${quiz.numberOfQuestions} questions',
                  style: titleStyle,
                ),
                SizedBox(height: 50),
                Text(
                  'Category: ${quiz.category}',
                  style: titleStyle,
                ),
                SizedBox(height: 50),
                Text(
                  'Author: ${quiz.author}',
                  style: titleStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
