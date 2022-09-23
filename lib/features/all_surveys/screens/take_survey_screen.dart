import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/features/all_surveys/get_controllers/take_survey_get_controller.dart';
import 'package:ikkjutt_jammu_survey_app/features/new_survey/models/survey_model.dart';
import 'package:ikkjutt_jammu_survey_app/widgets/question_widget.dart';
import 'package:ikkjutt_jammu_survey_app/widgets/standard_app_bar.dart';
import 'package:ikkjutt_jammu_survey_app/widgets/standard_button.dart';
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
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height - 2 * kToolbarHeight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: takeSurveyGetController.titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: takeSurveyGetController.descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
                SizedBox(
                  height: 10,
                ),
                Obx(() {
                  return TextWithFormat(
                    'Question ${takeSurveyGetController.questionIndex.value + 1} of ${takeSurveyGetController.surveyModel.questions.length}',
                    bold: true,
                    color: Colors.grey,
                    italic: true,
                  );
                }),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Obx(() {
                    return Stack(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            height: Get.height,
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            pauseAutoPlayOnTouch: true,
                            aspectRatio: 2.0,
                            onPageChanged: (index, reason) {
                              takeSurveyGetController.questionIndex.value =
                                  index;
                            },
                            enableInfiniteScroll: false,
                          ),
                          items: surveyModel.questions.map((question) {
                            if (question.questionType == 1) {
                              return FreeTextQuestionWidget(
                                  freeTextQuestionModel:
                                      question.freeTextQuestionModel!,
                                  answerTextController:
                                      takeSurveyGetController.answersVariable[
                                          takeSurveyGetController
                                              .questionIndex.value ]);
                            } else if (question.questionType == 2) {
                              return Column(
                                children: [
                                  TextWithFormat(
                                    question
                                        .trueFalseQuestionModel!.questionText,
                                    fontSize: 20,
                                    bold: true,
                                    maxLines: 5,
                                  ),
                                  Row(
                                    children: [
                                      TextWithFormat(
                                        'True',
                                        fontSize: 20,
                                        bold: true,
                                        maxLines: 5,
                                      ),
                                      Checkbox(
                                        value: takeSurveyGetController.answers[
                                            surveyModel.questions
                                                .indexOf(question)],
                                        onChanged: (value) {
                                          takeSurveyGetController.answers[
                                              surveyModel.questions
                                                  .indexOf(question)] = value!;
                                        },
                                      ),
                                      TextWithFormat(
                                        takeSurveyGetController.answers[
                                                surveyModel.questions
                                                    .indexOf(question)]
                                            .toString(),
                                        fontSize: 20,
                                        bold: true,
                                        maxLines: 5,
                                      ),
                                      Checkbox(
                                        value: takeSurveyGetController
                                                .answersVariable[
                                            surveyModel.questions
                                                .indexOf(question)][1],
                                        onChanged: (value) {
                                          takeSurveyGetController
                                                      .answersVariable[
                                                  surveyModel.questions
                                                      .indexOf(question)][1] =
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
                                    question
                                        .selectOneOptionQuestion!.questionText,
                                    fontSize: 20,
                                    bold: true,
                                    maxLines: 5,
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: question.selectOneOptionQuestion!
                                        .options.length,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          TextWithFormat(
                                            question.selectOneOptionQuestion!
                                                .options[index],
                                            fontSize: 20,
                                            bold: true,
                                            maxLines: 5,
                                          ),
                                          Radio(
                                            value: index,
                                            groupValue: takeSurveyGetController
                                                    .answersVariable[
                                                surveyModel.questions
                                                    .indexOf(question)],
                                            onChanged: (value) {
                                              takeSurveyGetController
                                                      .answersVariable[
                                                  question.questionNumber -
                                                      1] = value;
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
                                    question.selectMultipleOptionsQuestion!
                                        .questionText,
                                    fontSize: 20,
                                    bold: true,
                                    maxLines: 5,
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: question
                                        .selectMultipleOptionsQuestion!
                                        .options
                                        .length,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          TextWithFormat(
                                            question
                                                .selectMultipleOptionsQuestion!
                                                .options[index],
                                            fontSize: 20,
                                            bold: true,
                                            maxLines: 5,
                                          ),
                                          Checkbox(
                                            value: takeSurveyGetController
                                                    .answers[
                                                surveyModel.questions
                                                    .indexOf(question)][index],
                                            onChanged: (value) {
                                              takeSurveyGetController.answers[
                                                      surveyModel.questions
                                                          .indexOf(question)]
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
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: TextButton(
                              onPressed: () {},
                              child: Text('Next >>'),
                            ))
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(() {
        return Visibility(
          visible: takeSurveyGetController.questionIndex.value ==
              takeSurveyGetController.surveyModel.questions.length,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StandardButton(
              text: 'Submit',
              onPressed: () {},
            ),
          ),
        );
      }),
    );
  }
}
