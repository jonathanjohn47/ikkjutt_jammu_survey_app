import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/features/all_surveys/models/report_model.dart';
import 'package:ikkjutt_jammu_survey_app/widgets/standard_app_bar.dart';
import 'package:ikkjutt_jammu_survey_app/widgets/text_with_format.dart';

class ViewReportScreen extends StatelessWidget {
  final ReportModel reportModel;

  const ViewReportScreen({Key? key, required this.reportModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: StandardAppBar(
          title: reportModel.title,
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: Get.width,
          child: Table(
            columnWidths: {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(3),
            },
            children: [
              ...reportModel.surveyModel.questions.map((e) {
                return TableRow(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.2)),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextWithFormat(
                          (reportModel.surveyModel.questions.indexOf(e) + 1)
                              .toString(),
                          italic: true,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextWithFormat(
                          e.questionText,
                          maxLines: 10,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextWithFormat(
                          e.answerText,
                          maxLines: 10,
                          bold: true,
                        ),
                      ),
                    ]);
              }).toList()
            ],
          ),
        ),
      ),
    );
  }
}
