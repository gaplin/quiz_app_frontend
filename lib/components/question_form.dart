import 'package:flutter/material.dart';
import 'custom_text_field.dart';

class QuestionForm extends StatefulWidget {
  @override
  State<QuestionForm> createState() => _QuestionFormState();

  final TextEditingController questionTextController = TextEditingController();

  final TextEditingController correctAnswerController = TextEditingController();

  final List<TextEditingController> wrongAnswerControllers = [
    TextEditingController()
  ];
}

class _QuestionFormState extends State<QuestionForm> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        CustomTextField(
          controller: widget.questionTextController,
          label: "Question",
          minSymbols: 1,
          maxSymbols: 100,
        ),
        CustomTextField(
          controller: widget.correctAnswerController,
          label: "Correct Answer",
          minSymbols: 1,
          maxSymbols: 100,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.wrongAnswerControllers.length,
          itemBuilder: (context, index) {
            return CustomTextField(
              controller: widget.wrongAnswerControllers[index],
              label: "Wrong Answer ${index + 1}",
              minSymbols: 1,
              maxSymbols: 100,
            );
          },
        ),
        _getButtons(),
      ],
    );
  }

  Widget _getButtons() {
    List<Widget> buttons = [];
    if (widget.wrongAnswerControllers.length < 7) {
      buttons.add(ElevatedButton(
          onPressed: () {
            setState(() {
              widget.wrongAnswerControllers.add(TextEditingController());
            });
          },
          child: Text('Add Answer')));
    }
    if (widget.wrongAnswerControllers.length > 1) {
      if (buttons.isNotEmpty) buttons.add(SizedBox(width: 20));
      buttons.add(ElevatedButton(
          onPressed: () {
            setState(() {
              widget.wrongAnswerControllers.removeLast();
            });
          },
          child: Text('Remove Answer')));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 16,
      ),
      child: Row(children: buttons),
    );
  }
}
