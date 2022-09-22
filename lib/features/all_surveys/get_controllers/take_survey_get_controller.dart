import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/features/new_survey/models/survey_model.dart';

class TakeSurveyGetController extends GetxController {
  final SurveyModel surveyModel;

  TakeSurveyGetController(this.surveyModel);

  List<dynamic> answersVariable = [];

  void addAnswerVariable() {
    /*FreeTextQuestionModel? freeTextQuestionModel;
  TrueFalseQuestionModel? trueFalseQuestionModel;
  SelectOneOptionQuestion? selectOneOptionQuestion;
  SelectMultipleOptionsQuestion? selectMultipleOptionsQuestion;*/
    surveyModel.questions.forEach((question) {
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
  }

  @override
  void onInit() {
    addAnswerVariable();
    super.onInit();
  }
}
