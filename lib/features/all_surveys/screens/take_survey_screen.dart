import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/features/all_surveys/get_controllers/take_survey_get_controller.dart';
import 'package:ikkjutt_jammu_survey_app/features/new_survey/models/survey_model.dart';
import 'package:ikkjutt_jammu_survey_app/widgets/standard_app_bar.dart';
import 'package:ikkjutt_jammu_survey_app/widgets/text_with_format.dart';

class TakeSurveyScreen extends StatelessWidget {
  final SurveyModel surveyModel;

  const TakeSurveyScreen({Key? key, required this.surveyModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TakeSurveyGetController takeSurveyGetController =
        Get.put(TakeSurveyGetController(surveyModel));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: StandardAppBar(
          title: 'Take Survey',
        ),
      ),
      body: Obx(() {
        return CarouselSlider(
          options: CarouselOptions(
            height: Get.height,
            enlargeCenterPage: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            pauseAutoPlayOnTouch: true,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {},
          ),
          items: surveyModel.questions.map((question) {
            if (question.questionType == 1) {
              return Column(
                children: [
                  TextWithFormat(
                    question.freeTextQuestionModel!.questionText,
                    fontSize: 20,
                    bold: true,
                  ),
                  TextField(
                    controller: takeSurveyGetController.answersVariable[
                        surveyModel.questions.indexOf(question)],
                  ),
                ],
              );
            } else if (question.questionType == 2) {
              return Column(
                children: [
                  TextWithFormat(
                    question.trueFalseQuestionModel!.questionText,
                    fontSize: 20,
                    bold: true,
                  ),
                  Row(
                    children: [
                      TextWithFormat(
                        'True',
                        fontSize: 20,
                        bold: true,
                      ),
                      Checkbox(
                        value: takeSurveyGetController
                            .answers[surveyModel.questions.indexOf(question)],
                        onChanged: (value) {
                          takeSurveyGetController.answers[
                              surveyModel.questions.indexOf(question)] = value!;
                        },
                      ),
                      TextWithFormat(
                        takeSurveyGetController
                            .answers[surveyModel.questions.indexOf(question)]
                            .toString(),
                        fontSize: 20,
                        bold: true,
                      ),
                      Checkbox(
                        value: takeSurveyGetController.answersVariable[
                            surveyModel.questions.indexOf(question)][1],
                        onChanged: (value) {
                          takeSurveyGetController.answersVariable[
                                  surveyModel.questions.indexOf(question)][1] =
                              value!;
                        },
                      ),
                    ],
                  ),
                ],
              );
            } else if (question.questionType == 3) {
              return Column(
                children: [
                  TextWithFormat(
                    question.selectOneOptionQuestion!.questionText,
                    fontSize: 20,
                    bold: true,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: question.selectOneOptionQuestion!.options.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          TextWithFormat(
                            question.selectOneOptionQuestion!.options[index],
                            fontSize: 20,
                            bold: true,
                          ),
                          Radio(
                            value: index,
                            groupValue: takeSurveyGetController.answersVariable[
                                surveyModel.questions.indexOf(question)],
                            onChanged: (value) {
                              takeSurveyGetController.answersVariable[
                                  question.questionNumber - 1] = value;
                              takeSurveyGetController.update();
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              );
            } else if (question.questionType == 4) {
              return Column(
                children: [
                  TextWithFormat(
                    question.selectMultipleOptionsQuestion!.questionText,
                    fontSize: 20,
                    bold: true,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        question.selectMultipleOptionsQuestion!.options.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          TextWithFormat(
                            question
                                .selectMultipleOptionsQuestion!.options[index],
                            fontSize: 20,
                            bold: true,
                          ),
                          Checkbox(
                            value: takeSurveyGetController.answers[
                                surveyModel.questions.indexOf(question)][index],
                            onChanged: (value) {
                              takeSurveyGetController.answers[
                                      surveyModel.questions.indexOf(question)]
                                  [index] = value!;
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              );
            }
            return Container();
          }).toList(),
        );
      }),
    );
  }
}
