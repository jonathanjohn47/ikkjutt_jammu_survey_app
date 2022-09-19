import 'dart:math';

import 'package:ikkjutt_jammu_survey_app/features/new_survey/models/survey_model.dart';

class ReportModel {
  String id;
  String title;
  SurveyModel surveyModel;

  ReportModel(this.id, this.surveyModel, this.title);

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      json['id'],
      SurveyModel.fromJson(json['surveyModel']),
      json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'surveyModel': surveyModel.toJson(),
      'title': title,
    };
  }

  factory ReportModel.empty() {
    Random random = Random();
    return ReportModel(
      random.nextInt(100).toString(),
      SurveyModel.empty(),
      'Demo Report',
    );
  }
}
