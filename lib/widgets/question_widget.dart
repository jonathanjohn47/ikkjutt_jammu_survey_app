import 'package:flutter/material.dart';
import 'package:ikkjutt_jammu_survey_app/features/new_survey/models/question_model.dart';
import 'package:ikkjutt_jammu_survey_app/widgets/text_with_format.dart';

class FreeTextQuestionWidget extends StatelessWidget {
  final FreeTextQuestionModel freeTextQuestionModel;
  final TextEditingController answerTextController;

  const FreeTextQuestionWidget(
      {Key? key,
      required this.freeTextQuestionModel,
      required this.answerTextController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        TextWithFormat(
          freeTextQuestionModel.questionText,
          bold: true,
          fontSize: 20,
        ),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Answer',
              border: OutlineInputBorder(),
            ),
            controller: answerTextController,
          ),
        ),
      ],
    ));
  }
}

class TrueFalseQuestionWidget extends StatelessWidget {
  final TrueFalseQuestionModel trueFalseQuestionModel;
  final bool answer;
  final Function(bool) onAnswerChanged;

  const TrueFalseQuestionWidget(
      {Key? key,
      required this.trueFalseQuestionModel,
      required this.answer,
      required this.onAnswerChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextWithFormat(
            trueFalseQuestionModel.questionText,
            bold: true,
            fontSize: 20,
          ),
          ListTile(
            title: TextWithFormat(
              'True',
              bold: true,
            ),
            trailing: Radio(
              value: answer,
              groupValue: trueFalseQuestionModel.questionText,
              onChanged: (Object? value) {
                onAnswerChanged(true);
              },
            ),
          ),
          ListTile(
            title: TextWithFormat(
              'False',
              bold: true,
            ),
            trailing: Radio(
              value: answer,
              groupValue: trueFalseQuestionModel.questionText,
              onChanged: (Object? value) {
                onAnswerChanged(false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
