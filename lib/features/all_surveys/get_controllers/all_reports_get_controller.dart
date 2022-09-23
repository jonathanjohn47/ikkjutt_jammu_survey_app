import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/core/app_constants.dart';

import '../../new_survey/models/survey_model.dart';
import '../models/report_model.dart';

class AllReportsGetController extends GetxController {
  final SurveyModel surveyModel;

  AllReportsGetController(this.surveyModel);

  RxList<ReportModel> allReports = <ReportModel>[].obs;

  void fetchAllReports() {
    FirebaseFirestore.instance
        .collection(AppConstants.surveys)
        .doc(surveyModel.id)
        .collection(AppConstants.reports)
        .snapshots()
        .listen((event) {
      allReports.value = event.docs
          .map((e) => ReportModel.fromJson(jsonDecode(jsonEncode(e.data()))))
          .toList();
    });
  }

  @override
  void onInit() {
    fetchAllReports();
    super.onInit();
  }
}
