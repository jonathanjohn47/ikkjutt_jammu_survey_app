import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/widgets/standard_app_bar.dart';
import 'package:ikkjutt_jammu_survey_app/widgets/text_with_format.dart';

import '../../new_survey/models/survey_model.dart';
import '../get_controllers/report_screen_get_controller.dart';

class ReportScreen extends StatelessWidget {
  final SurveyModel surveyModel;

  ReportScreen({Key? key, required this.surveyModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    ReportScreenGetController reportScreenGetController =
        Get.put(ReportScreenGetController(surveyModel));
    return WillPopScope(
      onWillPop: () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: StandardAppBar(
            title: "Report",
            actions: [
              IconButton(
                  onPressed: () {
                    reportScreenGetController.saveAsPdf();
                  },
                  icon: Icon(Icons.print))
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: reportScreenGetController
                    .allReports[0].surveyModel.questions.length *
                200.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Table(
                border: TableBorder.all(),
                children: [
                  TableRow(children: [
                    ...reportScreenGetController
                        .allReports[0].surveyModel.questions
                        .map((e) => Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: TextWithFormat(
                                e.questionText,
                                bold: true,
                                maxLines: 5,
                              ),
                            )),
                  ]),
                  ...reportScreenGetController.allReports
                      .map((e) => TableRow(children: [
                            /*TextWithFormat(
                              (reportScreenGetController.allReports.indexOf(e) + 1)
                                  .toString(),
                              color: Colors.grey,
                              italic: true,
                            ),*/
                            ...e.surveyModel.questions
                                .map((e) => Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: TextWithFormat(
                                        e.answerText,
                                        maxLines: 10,
                                      ),
                                    ))
                                .toList()
                          ]))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
