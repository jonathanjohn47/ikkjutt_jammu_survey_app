import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/features/new_survey/models/survey_model.dart';

class AllSurveysGetController extends GetxController {
  RxList<SurveyModel> allSurveys = <SurveyModel>[].obs;

  @override
  void onInit() {

    super.onInit();
  }
}
