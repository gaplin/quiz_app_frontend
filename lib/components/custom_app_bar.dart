import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/login_state.dart';
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
          titleTextStyle: theme.textTheme.displaySmall!.copyWith(
            color: theme.colorScheme.onTertiaryContainer,
          ),
          title: Text('QuizApp'),
          backgroundColor: theme.colorScheme.tertiaryContainer,
          actions: actions,
        );
      },
    );
  }

  List<Widget> _getActions(LoginState state, BuildContext context) {
    List<Widget> result = [];
    if (state.token == null) {
      result.add(ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        },
        child: Text('log in'),
      ));
      result.add(ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => RegisterPage(),
            ),
          );
        },
        child: Text('Register'),
      ));
    } else {
      result.add(ElevatedButton(
        onPressed: () async {
          await state.setToken(null);
        },
        child: Text('log out'),
      ));
    }
    return result;
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
