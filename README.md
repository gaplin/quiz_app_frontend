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
- Json serialization with Source code generated mappers
- User accounts
- Adding/deleting quizzes by users

## Preview
![image](https://github.com/gaplin/quiz_app_frontend/assets/50521366/e2b49eb1-7c6e-475c-a0b4-ce7ecbad0b06)

![image](https://github.com/gaplin/quiz_app_frontend/assets/50521366/216e6b00-a6c7-4f5e-b6a5-191cbd107edc)

