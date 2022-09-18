import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/features/new_survey/models/survey_model.dart';

class AllSurveysGetController extends GetxController {
  RxList<SurveyModel> allSurveys = <SurveyModel>[].obs;

  void fetchAllSurveys() {
    for (int i = 0; i < 10; i++) {
      allSurveys.add(SurveyModel.empty());
    }
  }

  @override
  void onInit() {
    fetchAllSurveys();
    super.onInit();
  }
}
