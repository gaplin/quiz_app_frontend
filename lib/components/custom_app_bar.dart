import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_frontend/pages/quizzes_page.dart';

import '../model/login_state.dart';
import '../pages/create_quiz_page.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<LoginState>(
      builder: (context, loginState, child) {
        var actions = _getActions(
          loginState,
          context,
        );
        return AppBar(
          automaticallyImplyLeading: false,
          titleTextStyle: theme.textTheme.headlineMedium!.copyWith(
            color: theme.colorScheme.onTertiaryContainer,
          ),
          title: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => QuizzesPage(),
                    ),
                  );
                },
                child: Text('QuizApp')),
          ),
          backgroundColor: theme.colorScheme.tertiaryContainer,
          actions: actions,
        );
      },
    );
  }

  List<Widget> _getActions(LoginState state, BuildContext context) {
    List<Widget> result = [];
    if (state.token == null) {
      result.add(IconButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        },
        icon: Icon(Icons.login),
      ));
      result.add(SizedBox(width: 20));
      result.add(IconButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => RegisterPage(),
            ),
          );
        },
        icon: Icon(Icons.app_registration),
      ));
    } else {
      result.add(Text('Hello ${state.userName}'));
      result.add(SizedBox(width: 20));
      result.add(
        IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => CreateQuizPage(),
              ),
            );
          },
          icon: Icon(Icons.add),
        ),
      );
      result.add(SizedBox(width: 20));
      result.add(
        IconButton(
          onPressed: () async {
            await state.setToken(null);
          },
          icon: Icon(Icons.logout),
        ),
      );
    }
    result.add(SizedBox(width: 10));
    return result;
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
