import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/features/new_survey/models/survey_model.dart';
import 'package:ikkjutt_jammu_survey_app/widgets/standard_app_bar.dart';

class TakeSurveyScreen extends StatelessWidget {
  final SurveyModel surveyModel;

  const TakeSurveyScreen({Key? key, required this.surveyModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: StandardAppBar(
          title: 'Take Survey',
        ),
      ),
      body: CarouselSlider(
        options: CarouselOptions(
          height: Get.height,
          enlargeCenterPage: true,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 2),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          pauseAutoPlayOnTouch: true,
          aspectRatio: 2.0,
          onPageChanged: (index, reason) {},
        ),
        items: surveyModel.questions
            .map((item) => Container(
                  child: Center(
                      child: Text(
                    item.questionText,
                    style: TextStyle(fontSize: 16.0),
                  )),
                ))
            .toList(),
      ),
    );
  }
}
