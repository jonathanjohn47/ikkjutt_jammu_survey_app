import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/core/app_colors.dart';
import 'package:ikkjutt_jammu_survey_app/features/all_surveys/get_controllers/all_reports_get_controller.dart';
import 'package:ikkjutt_jammu_survey_app/features/all_surveys/models/report_model.dart';
import 'package:ikkjutt_jammu_survey_app/features/all_surveys/screens/take_survey_screen.dart';
import 'package:ikkjutt_jammu_survey_app/features/all_surveys/screens/view_report_screen.dart';
import 'package:ikkjutt_jammu_survey_app/features/new_survey/models/survey_model.dart';
import 'package:ikkjutt_jammu_survey_app/widgets/custom_divider.dart';
import 'package:ikkjutt_jammu_survey_app/widgets/standard_button.dart';
import 'package:ikkjutt_jammu_survey_app/widgets/text_with_format.dart';

import '../../../core/app_constants.dart';
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
          title: 'Reports for ${surveyModel.title}',
          actions: [
            TextButton(
                child: TextWithFormat('Finish Survey',
                    color: AppColors.secondaryHeaderColor.shade700),
                onPressed: () {
                  Get.dialog(AlertDialog(
                    title: Text('Finish Survey'),
                    content:
                        Text('Are you sure you want to finish this survey?'),
                    actions: [
                      StandardButton(
                        text: 'Yes',
                        onPressed: () {
                          Get.back();
                          Get.back();
                        },
                      ),
                      StandardButton(
                        text: 'No',
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ],
                  ));
                })
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(AppConstants.surveys)
              .doc(surveyModel.id)
              .collection(AppConstants.reports)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ReportModel> allReports = snapshot.data!.docs
                  .map((e) =>
                      ReportModel.fromJson(jsonDecode(jsonEncode(e.data()))))
                  .toList();
              allReports.sort((a, b) => b.submittedAt.compareTo(a.submittedAt));
              return ListView.builder(
                itemBuilder: (context, index) {
                  ReportModel reportModel = allReports[index];
                  return Column(
                    children: [
                      reportModel.description != null
                          ? ListTile(
                              title: Text(reportModel.title),
                              subtitle: Text(reportModel.description!),
                              onTap: () {
                                Get.to(() => ViewReportScreen(
                                      reportModel: allReportsGetController
                                          .allReports[index],
                                    ));
                              })
                          : ListTile(
                              title: Text(reportModel.title),
                            ),
                      CustomDivider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ],
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            }
            return Center(
              child: CircularProgressIndicator(),
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
