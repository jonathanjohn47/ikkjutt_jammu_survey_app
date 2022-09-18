import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/features/admin_dashboard/screens/admin_dashboard.dart';

class LoginAdminController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool showPassword = false.obs;

  void login() {
    Get.off(() => AdminDashboard());
  }
}
