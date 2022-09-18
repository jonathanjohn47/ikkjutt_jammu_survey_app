import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/core/app_colors.dart';
import 'package:ikkjutt_jammu_survey_app/features/new_survey/models/question_model.dart';
import 'package:ikkjutt_jammu_survey_app/helpers/date_time_helper.dart';
import 'package:ikkjutt_jammu_survey_app/widgets/standard_button.dart';
import 'package:ikkjutt_jammu_survey_app/widgets/standard_divider.dart';
import 'package:ikkjutt_jammu_survey_app/widgets/text_with_format.dart';

import '../../../widgets/standard_app_bar.dart';
import '../get_controllers/new_survey_get_controller.dart';

class NewSurveyScreen extends StatelessWidget {
  NewSurveyScreen({Key? key}) : super(key: key);

  NewSurveyGetController newSurveyGetController =
      Get.put(NewSurveyGetController());

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Scaffold(
        backgroundColor:
            AppColors.secondaryHeaderColor.shade50.withOpacity(0.1),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: StandardAppBar(
              title: 'New Survey',
            )),
        body: SingleChildScrollView(
          child: SizedBox(
            width: Get.width,
            height: Get.height - 2.5 * kToolbarHeight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Title',
                      hintText: 'Enter title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'Enter description',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 50,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Area',
                      hintText: 'Enter area',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Scheduled At'),
                      trailing: Obx(() {
                        return TextWithFormat(
                          newSurveyGetController.scheduledAt.value
                              .dateTimeStringWithMonthNameAndAmPm,
                          italic: true,
                        );
                      }),
                      onTap: () {
                        newSurveyGetController.pickScheduledAt();
                      },
                    ),
                  ),
                  StandardDivider(),
                  Obx(() {
                    return TextWithFormat(
                      'Questions: ${newSurveyGetController.questions.length}',
                      fontSize: 18,
                    );
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    child: Obx(() {
                      return ListView.builder(
                          itemCount: newSurveyGetController.questions.length,
                          itemBuilder: (context, index) {
                            QuestionModel question =
                                newSurveyGetController.questions[index];

                            return Card(
                              child: ListTile(
                                title: TextWithFormat(question.questionText),
                              ),
                            );
                          });
                    }),
                  ),
                  StandardDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Card(
                        elevation: 0,
                        color: AppColors.primaryColor.shade700,
                        child: TextButton(
                          child: TextWithFormat(
                            '+ Add Question',
                            color: Colors.white,
                          ),
                          onPressed: () {
                            newSurveyGetController.addQuestion();
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StandardButton(
            text: 'Create Survey',
            onPressed: () {
              newSurveyGetController.createSurvey();
            },
          ),
        ),
      ),
    );
  }
}
