import 'dart:math';

import 'package:ikkjutt_jammu_survey_app/features/new_survey/models/survey_model.dart';

class ReportModel {
  String id;
  String title;
  String? description;
  SurveyModel surveyModel;
  double latitude;
  double longitude;

  ReportModel(
      {required this.id,
      required this.surveyModel,
      required this.title,
      required this.description,
      required this.latitude,
      required this.longitude});

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      surveyModel: SurveyModel.fromJson(json['surveyModel']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'surveyModel': surveyModel.toJson(),
    };
  }

  factory ReportModel.empty() {
    Random random = Random();
    return ReportModel(
      id: random.nextInt(100000).toString(),
      title: '',
      description: '',
      latitude: 0.0,
      longitude: 0.0,
      surveyModel: SurveyModel.empty(),
    );
  }
}
