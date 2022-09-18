import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/features/all_surveys/screens/report_screen.dart';
import 'package:ikkjutt_jammu_survey_app/features/all_surveys/screens/take_survey_screen.dart';
import 'package:ikkjutt_jammu_survey_app/widgets/custom_divider.dart';

import '../../../core/app_colors.dart';
import '../../../widgets/standard_app_bar.dart';
import '../get_controllers/all_surveys_get_controller.dart';

class AllSurveysScreen extends StatelessWidget {
  AllSurveysScreen({Key? key}) : super(key: key);

  AllSurveysGetController allSurveysGetController =
      Get.put(AllSurveysGetController());

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
                title: 'All Surveys',
              )),
          body: ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (allSurveysGetController.allSurveys[index].isCompleted) {
                    Get.to(() => ReportScreen(
                          surveyModel:
                              allSurveysGetController.allSurveys[index],
                        ));
                  } else {
                    Get.to(() => TakeSurveyScreen());
                  }
                },
                child: Card(
                  elevation:
                      allSurveysGetController.allSurveys[index].isCompleted
                          ? 0
                          : 2,
                  color: allSurveysGetController.allSurveys[index].isCompleted
                      ? Colors.transparent
                      : Colors.white,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                            allSurveysGetController.allSurveys[index].title),
                        subtitle: Text(allSurveysGetController
                            .allSurveys[index].description),
                      ),
                      CustomDivider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      ListTile(
                        title: Text('Number of Questions:'),
                        trailing: Text(allSurveysGetController
                            .allSurveys[index].questions.length
                            .toString()),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: allSurveysGetController.allSurveys.length,
          )),
    );
  }
}
