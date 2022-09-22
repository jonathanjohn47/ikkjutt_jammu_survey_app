import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/features/all_surveys/get_controllers/all_reports_get_controller.dart';
import 'package:ikkjutt_jammu_survey_app/features/all_surveys/screens/take_survey_screen.dart';
import 'package:ikkjutt_jammu_survey_app/features/all_surveys/screens/view_report_screen.dart';
import 'package:ikkjutt_jammu_survey_app/features/new_survey/models/survey_model.dart';
import 'package:ikkjutt_jammu_survey_app/widgets/custom_divider.dart';
import 'package:ikkjutt_jammu_survey_app/widgets/standard_button.dart';

import '../../../widgets/standard_app_bar.dart';

class AllReportsScreen extends StatelessWidget {
  final SurveyModel surveyModel;

  const AllReportsScreen({Key? key, required this.surveyModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllReportsGetController allReportsGetController =
        Get.put(AllReportsGetController(surveyModel));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: StandardAppBar(
          title: 'Reports',
        ),
      ),
      body: Obx(() {
        return ListView.builder(
          itemBuilder: (context, index) {
            return Column(
              children: [
                allReportsGetController.allReports[index].description != null
                    ? ListTile(
                        title: Text(
                            allReportsGetController.allReports[index].title),
                        subtitle: Text(allReportsGetController
                            .allReports[index].description!),
                        onTap: () {
                          Get.to(() => ViewReportScreen(
                                reportModel:
                                    allReportsGetController.allReports[index],
                              ));
                        })
                    : ListTile(
                        title: Text(
                            allReportsGetController.allReports[index].title),
                      ),
                CustomDivider(
                  thickness: 1,
                  color: Colors.grey,
                ),
              ],
            );
          },
          itemCount: allReportsGetController.allReports.length,
        );
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StandardButton(
          text: 'New Report',
          onPressed: () {
            Get.to(() => TakeSurveyScreen(surveyModel: surveyModel));
          },
          icon: Icons.add,
        ),
      ),
    );
  }
}
