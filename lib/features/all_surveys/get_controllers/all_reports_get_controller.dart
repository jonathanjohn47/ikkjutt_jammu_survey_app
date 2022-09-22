import 'package:get/get.dart';

import '../../new_survey/models/survey_model.dart';
import '../models/report_model.dart';

class AllReportsGetController extends GetxController {
  final SurveyModel surveyModel;

  AllReportsGetController(this.surveyModel);

  RxList<ReportModel> allReports = <ReportModel>[].obs;

  void fetchAllReports() {
    for (int i = 0; i < 10; i++) {
      allReports.add(ReportModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: 'Report $i',
        description: 'Description $i',
        latitude: 0.0,
        longitude: 0.0,
        surveyModel: SurveyModel.empty(),
      ));
    }
  }

  @override
  void onInit() {
    fetchAllReports();
    super.onInit();
  }
}
