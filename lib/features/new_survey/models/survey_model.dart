import 'dart:math';

import 'package:ikkjutt_jammu_survey_app/features/new_survey/models/question_model.dart';

class SurveyModel {
  String id;
  String title;
  String description;
  DateTime scheduledAt;
  String area;
  bool isCompleted;
  List<QuestionModel> questions;

  SurveyModel({
    required this.id,
    required this.title,
    required this.description,
    required this.scheduledAt,
    required this.area,
    required this.isCompleted,
    required this.questions,
  });

  factory SurveyModel.fromJson(Map<String, dynamic> json) {
    return SurveyModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      scheduledAt: DateTime.fromMillisecondsSinceEpoch(json['scheduled_at']),
      area: json['area'],
      isCompleted: json['is_completed'],
      questions: List<QuestionModel>.from(
          json['questions'].map((x) => QuestionModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'scheduled_at': scheduledAt.millisecondsSinceEpoch,
      'area': area,
      'is_completed': isCompleted,
      'questions': questions.map((x) => x.toJson()).toList(),
    };
  }

  factory SurveyModel.empty() {
    Random random = new Random();
    return SurveyModel(
      id: '',
      title: 'Demo Survey',
      description: 'Demo Survey Description',
      scheduledAt: DateTime.now(),
      area: 'Srinagar',
      isCompleted: random.nextBool(),
      questions: [
        QuestionModel(
            trueFalseQuestionModel: TrueFalseQuestionModel(
          questionText: 'How Are You?',
        )),
      ],
    );
  }
}
