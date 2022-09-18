import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/features/add_new_member/models/member_model.dart';

class MemberProfileScreenGetController extends GetxController {
  final MemberModel memberModel;

  MemberProfileScreenGetController(this.memberModel);

  late Rx<MemberModel> newMemberModel;

  RxBool changeDesignation = false.obs;
  RxBool changePhoneNumber = false.obs;
  RxInt numberOfSurveysAttended = 0.obs;
  RxInt numberOfEventsAttended = 0.obs;

  TextEditingController designationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  listenToMember() {}

  fetchNumberOfSurveys() {}

  @override
  void onInit() {
    newMemberModel = memberModel.obs;
    super.onInit();
  }

  void deleteMember() {
    Get.dialog(AlertDialog(
      title: Text('Delete Member'),
      content: Text(
          'Are you sure you want to delete this member?\nThis cannot be undone.'),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Cancel')),
        TextButton(
            onPressed: () {
              Get.back();
              Get.back();
            },
            child: Text('Delete'))
      ],
    ));
  }
}
