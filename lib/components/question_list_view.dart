import 'package:flutter/material.dart';
import 'package:quiz_app_frontend/components/title_card.dart';

import '../model/question.dart';

class QuestionListView extends StatelessWidget {
  final Question question;
  final Function(bool) callBack;

  const QuestionListView({
    super.key,
    required this.question,
    required this.callBack,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: question.answers.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: TitleCard(
              title: question.text,
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                var correctAnswer = false;
                if (index - 1 == question.correctAnswer) correctAnswer = true;
                callBack(correctAnswer);
              },
              child: Text(question.answers[index - 1]),
            ),
          );
        }
      },
    );
  }
}
