import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/features/new_survey/models/survey_model.dart';

class TakeSurveyGetController extends GetxController {
  final SurveyModel surveyModel;

  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TakeSurveyGetController(this.surveyModel);

  RxList<dynamic> answersVariable = [].obs;
  RxList<dynamic> answers = [].obs;

  RxInt questionIndex = 0.obs;

  void addAnswerVariable() {
    surveyModel.questions.forEach((question) {
      print("Question type: ${question.questionType}");
      if (question.questionType == 1) {
        answersVariable.add(TextEditingController());
      } else if (question.questionType == 2) {
        answersVariable.add([true, false]);
      } else if (question.questionType == 3) {
        answersVariable.add(question.selectOneOptionQuestion!.options);
      } else if (question.questionType == 4) {
        answersVariable.add(question.selectMultipleOptionsQuestion!.options);
      }
    });

    answers.value = List.generate(answersVariable.length, (index) {
      if (surveyModel.questions[index].questionType == 1) {
        return '';
      } else if (surveyModel.questions[index].questionType == 2) {
        return false;
      } else if (surveyModel.questions[index].questionType == 3) {
        return surveyModel.questions[index].selectOneOptionQuestion!.options[0];
      } else if (surveyModel.questions[index].questionType == 4) {
        return surveyModel
            .questions[index].selectMultipleOptionsQuestion!.options[0];
      } else {
        return '';
      }
    });
  }

  @override
  void onInit() {
    addAnswerVariable();
    super.onInit();
  }
}
