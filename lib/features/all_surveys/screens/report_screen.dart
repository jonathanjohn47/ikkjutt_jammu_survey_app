import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/widgets/standard_app_bar.dart';
import 'package:ikkjutt_jammu_survey_app/widgets/text_with_format.dart';

import '../../new_survey/models/survey_model.dart';
import '../get_controllers/report_screen_get_controller.dart';

class ReportScreen extends StatelessWidget {
  final SurveyModel surveyModel;

  late ScrollController _verticalScrollController;

  late ScrollController _horizontalScrollController;

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
        body: SizedBox(
          width: Get.width * 2,
          child: DataTable2(
            columnSpacing: 5,
            horizontalMargin: 2,
            minWidth: 1500,
            columns: [
              DataColumn2(size: ColumnSize.S, label: TextWithFormat('S.No.')),
              ...reportScreenGetController.allReports[0].surveyModel.questions
                  .map((e) => DataColumn2(
                      size: ColumnSize.L,
                      label: TextWithFormat(
                        e.questionText,
                        bold: true,
                        maxLines: 4,
                      )))
            ],
            rows: [
              ...reportScreenGetController.allReports
                  .map((e) => DataRow(cells: [
                        DataCell(TextWithFormat(
                            (reportScreenGetController.allReports.indexOf(e) +
                                    1)
                                .toString())),
                        ...e.surveyModel.questions
                            .map((e) => DataCell(TextWithFormat(
                                  e.answerText,
                                  maxLines: 5,
                                )))
                      ]))
            ],
          ),
        ),
        /*body: SingleChildScrollView(
          child: SingleChildScrollView(
            child: SizedBox(
              width: reportScreenGetController
                      .allReports[0].surveyModel.questions.length *
                  200.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  columnWidths: {
                    0: FlexColumnWidth(1),
                    ...Map.fromIterable(reportScreenGetController.allReports,
                        key: (e) =>
                            reportScreenGetController.allReports.indexOf(e) + 1,
                        value: (e) => FlexColumnWidth(surveyModel.questions.length
                            .toDouble())),
                  },
                  border: TableBorder.all(),
                  children: [
                    TableRow(children: [
                      Container(),
                      ...reportScreenGetController
                          .allReports[0].surveyModel.questions
                          .map((e) => Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: TextWithFormat(
                                  e.questionText,
                                  bold: true,
                                  maxLines: 4,
                                ),
                              )),
                    ]),
                    ...reportScreenGetController.allReports
                        .map((e) => TableRow(children: [
                              TextWithFormat(
                                (reportScreenGetController.allReports
                                            .indexOf(e) +
                                        1)
                                    .toString(),
                                color: Colors.grey,
                                italic: true,
                              ),
                              ...e.surveyModel.questions
                                  .map((e) => Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: TextWithFormat(
                                          e.answerText,
                                          maxLines: 4,
                                        ),
                                      ))
                                  .toList()
                            ]))
                  ],
                ),
              ),
            ),
          ),
        ),*/
      ),
    );
  }
}
