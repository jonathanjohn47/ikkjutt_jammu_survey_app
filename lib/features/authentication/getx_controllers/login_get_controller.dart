import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/core/app_constants.dart';

import '../../admin_dashboard/screens/admin_dashboard.dart';

class LoginGetController extends GetxController {
  void checkIfUserIsLoggedIn() {
    String? currentUserEmail = FirebaseAuth.instance.currentUser!.email;
    if (currentUserEmail == null) {
      String phoneNumber = FirebaseAuth.instance.currentUser!.phoneNumber!;
    } else {
      FirebaseFirestore.instance
          .collection(AppConstants.admins)
          .doc(currentUserEmail)
          .get()
          .then((value) {
        if (value.exists) {
          Get.offAll(() => AdminDashboard());
        } else {
          FirebaseAuth.instance.signOut();
        }
      });
    }
  }

  @override
  void onInit() {
    checkIfUserIsLoggedIn();
    super.onInit();
  }
}
