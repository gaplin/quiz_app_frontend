import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_frontend/model/login_state.dart';

import '../api_client/rest_client.dart';
import '../model/quiz_base.dart';
import '../pages/quiz_page.dart';

class QuizCard extends StatelessWidget {
  const QuizCard({
    super.key,
    required this.quiz,
    required this.quizDeletedCallback,
  });

  final QuizBase quiz;
  final Function(String) quizDeletedCallback;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.titleLarge!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Consumer<LoginState>(
      builder: (context, loginState, child) {
        return Card(
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
              child: Column(
                children: _listViewWidgets(titleStyle, loginState, context),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _listViewWidgets(
      TextStyle titleStyle, LoginState loginState, BuildContext context) {
    final result = [
      Text(
        quiz.title,
        style: titleStyle,
      ),
      SizedBox(height: 20),
      Text(
        '${quiz.numberOfQuestions} questions',
        style: titleStyle,
      ),
      SizedBox(height: 20),
      Text(
        'Category: ${quiz.category}',
        style: titleStyle,
      ),
      SizedBox(height: 20),
      Text(
        'Author: ${quiz.author}',
        style: titleStyle,
      ),
    ];
    if (loginState.role == 'Admin' || loginState.userId == quiz.authorId) {
      // set up the buttons
      Widget cancelButton = ElevatedButton(
        child: Text("No"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      Widget continueButton = ElevatedButton(
        child: Text("Yes"),
        onPressed: () async {
          RestClient client = RestClient.withToken(loginState.token);
          final success = await client.deleteQuiz(quiz.id);
          var snackBarMessage = 'Something went wrong';
          if (success) {
            quizDeletedCallback(quiz.id);
            snackBarMessage = 'Quiz deleted';
          }
          if (context.mounted) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(snackBarMessage),
              ),
            );
          }
        },
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Delete quiz ${quiz.title}"),
        content: Text("Are you sure?"),
        actions: [
          cancelButton,
          continueButton,
        ],
      );
      result.add(SizedBox(height: 20));
      result.add(
        Center(
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return alert;
                  });
            },
            child: Text('Delete Quiz'),
          ),
        ),
      );
    }
    return result;
  }
}
