import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/features/authentication/screens/login_page.dart';

class SplashGetController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void onInit() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.forward().then((value) {
      Future.delayed(Duration(seconds: 2), () {
        Get.offAll(() => LoginPage());
      });
    });
    super.onInit();
  }
}
