import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/core/app_constants.dart';
import 'package:ikkjutt_jammu_survey_app/features/all_surveys/screens/all_reports_screen.dart';
import 'package:ikkjutt_jammu_survey_app/features/all_surveys/screens/report_screen.dart';
import 'package:ikkjutt_jammu_survey_app/features/new_survey/models/survey_model.dart';
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
          body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(AppConstants.surveys)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<SurveyModel> allSurveys = snapshot.data!.docs
                      .map((e) => SurveyModel.fromJson(
                          jsonDecode(jsonEncode(e.data()))))
                      .toList();
                  allSurveys.sort((a, b) =>
                      b.scheduledAt.compareTo(a.scheduledAt)); // sort by date
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      SurveyModel surveyModel = allSurveys[index];
                      return GestureDetector(
                        onTap: () {
                          if (surveyModel.isCompleted) {
                            Get.to(() => ReportScreen(
                                  surveyModel: surveyModel,
                                ));
                          } else {
                            Get.to(() =>
                                AllReportsScreen(surveyModel: surveyModel));
                          }
                        },
                        child: Card(
                          elevation: surveyModel.isCompleted ? 0 : 2,
                          color: surveyModel.isCompleted
                              ? Colors.transparent
                              : Colors.white,
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(surveyModel.title),
                                subtitle: Text(surveyModel.description),
                              ),
                              CustomDivider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              ListTile(
                                title: Text('Number of Questions:'),
                                trailing: Text(
                                    surveyModel.questions.length.toString()),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: snapshot.data!.docs.length,
                  );
                }
                return Center(child: CircularProgressIndicator());
              })),
    );
  }
}
