import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      titleTextStyle: theme.textTheme.displaySmall!.copyWith(
        color: theme.colorScheme.onTertiaryContainer,
      ),
      title: Text('QuizApp'),
      backgroundColor: theme.colorScheme.tertiaryContainer,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
