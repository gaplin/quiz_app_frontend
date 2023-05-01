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
    final titleStyle = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary,
      child: InkWell(
        onTap: () => {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => QuizPage(quizId: quiz.id)))
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            quiz.title,
            style: titleStyle,
          ),
        ),
      ),
    );
  }
}
