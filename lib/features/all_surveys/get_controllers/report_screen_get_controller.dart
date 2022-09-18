import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/features/all_surveys/models/report_model.dart';
import 'package:ikkjutt_jammu_survey_app/features/new_survey/models/survey_model.dart';

class ReportScreenGetController extends GetxController {
  final SurveyModel surveyModel;

  ReportScreenGetController(this.surveyModel);

  RxList<ReportModel> allReports = <ReportModel>[].obs;

  void getAllReports() {
    ReportModel reportModel = ReportModel.empty();
    for (int i = 0; i < 10; i++) {
      allReports.add(reportModel);
    }
    allReports.forEach((element) {
      element.surveyModel.questions.forEach((question) {
        print("Question: " + question.questionText);
        print("Answer: " + question.answerText);
      });
    });
  }

  @override
  void onInit() {
    getAllReports();
    super.onInit();
  }
}
