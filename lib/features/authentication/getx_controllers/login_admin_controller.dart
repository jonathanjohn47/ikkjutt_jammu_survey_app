import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/core/app_constants.dart';
import 'package:ikkjutt_jammu_survey_app/features/admin_dashboard/screens/admin_dashboard.dart';

class LoginAdminController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool showPassword = false.obs;
  RxBool showLoader = false.obs;

  void login() {
    showLoader.value = true;
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: AppConstants.temporarySigningInEmail,
            password: AppConstants.temporarySigningInPassword)
        .then((value) {
      FirebaseFirestore.instance
          .collection(AppConstants.admins)
          .doc(emailController.text)
          .get()
          .then((value) {
        FirebaseAuth.instance.signOut();
        showLoader.value = false;
        if (value.exists) {
          FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text)
              .then((value) {
            Get.offAll(() => AdminDashboard());
          }).catchError((e) {
            Get.snackbar('Error', e.toString());
          });
        } else {
          Get.snackbar(
            'Error',
            'No such admin found',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      });
    });
  }
}
