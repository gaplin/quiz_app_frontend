# QuizApp
QuizApp written in flutter.
Frontend for [this](https://github.com/gaplin/QuizApp.Backend) REST API.<br>
App can be build for any available environment. Tested on web/windows/android.


## Features
- Communiaction with Rest API
- Configuration available in appsettings files
  - there is `launch.json` file included for vscode build
  - use `--dart-define-from-file=appsettings.[mode].json` flag for compilation to include variables for json file
- Managing state by using ChangeNotifier
- Json serialization by using Source code generator
- User accounts
- Adding/deleting quizzes by users

## Preview
![image](https://github.com/gaplin/quiz_app_frontend/assets/50521366/c8abba91-1965-4d97-b2ea-67497cc50e3c)

![image](https://github.com/gaplin/quiz_app_frontend/assets/50521366/41b1cf44-3a30-426c-a494-ffd579bd540f)

