import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/features/splash_screen/get_controllers/spash_get_controller.dart';

import '../../../core/app_colors.dart';

class SplashScreenPage extends StatelessWidget {
  SplashScreenPage({Key? key}) : super(key: key);

  SplashGetController _splashGetController = Get.put(SplashGetController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 1), () {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.secondaryHeaderColor.shade700,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ));
    });
    return Scaffold(
      body: Center(
        child: FadeTransition(
            opacity: _splashGetController.animationController,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/images/logo.jpeg'),
            )),
      ),
    );
  }
}
