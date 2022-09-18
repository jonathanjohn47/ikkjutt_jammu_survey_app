import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/features/all_surveys/models/report_model.dart';
import 'package:ikkjutt_jammu_survey_app/features/new_survey/models/survey_model.dart';

class ReportScreenGetController extends GetxController {
  final SurveyModel surveyModel;

  ReportScreenGetController(this.surveyModel);

  RxList<ReportModel> allReports = <ReportModel>[].obs;

  void getAllReports() {
    for (int i = 0; i < 10; i++) {
      allReports.add(ReportModel.empty());
    }
  }

  @override
  void onInit() {
    getAllReports();
    super.onInit();
  }
}
