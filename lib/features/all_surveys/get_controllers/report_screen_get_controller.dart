import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/features/all_surveys/models/report_model.dart';
import 'package:ikkjutt_jammu_survey_app/features/new_survey/models/survey_model.dart';
import 'package:ikkjutt_jammu_survey_app/helpers/date_time_helper.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ReportScreenGetController extends GetxController {
  final SurveyModel surveyModel;

  ReportScreenGetController(this.surveyModel);

  RxList<ReportModel> allReports = <ReportModel>[].obs;

  void getAllReports() {
    ReportModel reportModel = ReportModel.empty();
    for (int i = 0; i < 10; i++) {
      ReportModel newReportModel = ReportModel(
          DateTime.now().millisecondsSinceEpoch.toString(),
          reportModel.surveyModel,
          reportModel.title);
      allReports.add(newReportModel);
    }
  }

  Future<void> saveAsPdf() async {
    final pdf = pw.Document();
    //read asset image as bytes
    final image = pw.MemoryImage(
      (await rootBundle.load('assets/images/logo.jpeg')).buffer.asUint8List(),
    );
    PdfGoogleFonts.nunitoRegular().then((font) {
      pdf.addPage(pw.MultiPage(
          maxPages: 100,
          pageFormat: PdfPageFormat.a4,
          orientation: pw.PageOrientation.landscape,
          build: (pw.Context context) {
            return [
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.SizedBox(
                        width: PdfPageFormat.a4.width * 0.2,
                        height: PdfPageFormat.a4.width * 0.2,
                        child: pw.Image(
                          image,
                        )),
                    pw.Text(
                      'SURVEY REPORT',
                      style: pw.TextStyle(
                        fontSize: 40,
                        fontWeight: pw.FontWeight.bold,
                        font: font,
                      ),
                    ),
                  ]),
              pw.SizedBox(height: 20),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Survey Title:',
                      style: pw.TextStyle(
                        fontSize: 20,
                        font: font,
                      ),
                    ),
                    pw.Text(
                      allReports[0].surveyModel.title,
                      style: pw.TextStyle(
                        fontSize: 25,
                        fontWeight: pw.FontWeight.bold,
                        font: font,
                      ),
                    ),
                  ]),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Date:',
                      style: pw.TextStyle(
                        fontSize: 20,
                        font: font,
                      ),
                    ),
                    pw.Text(
                      surveyModel.scheduledAt.dateStringWithMonthName,
                      style: pw.TextStyle(
                        fontSize: 25,
                        fontWeight: pw.FontWeight.bold,
                        font: font,
                      ),
                    ),
                  ]),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Area:',
                      style: pw.TextStyle(
                        fontSize: 20,
                        font: font,
                      ),
                    ),
                    pw.Text(
                      surveyModel.area,
                      style: pw.TextStyle(
                        fontSize: 25,
                        fontWeight: pw.FontWeight.bold,
                        font: font,
                      ),
                    ),
                  ]),
              pw.Table(
                  columnWidths: {
                    0: pw.FlexColumnWidth(1),
                    ...Map.fromIterable(
                      allReports,
                      key: (e) => allReports.indexOf(e) + 1,
                      value: (e) => pw.FlexColumnWidth(5),
                    ),
                  },
                  border: pw.TableBorder.all(),
                  children: [
                    pw.TableRow(children: [
                      pw.Container(),
                      ...allReports[0]
                          .surveyModel
                          .questions
                          .map((e) => pw.Padding(
                          padding: pw.EdgeInsets.all(4),
                          child: pw.Text(
                            e.questionText,
                            style: pw.TextStyle(
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold,
                              font: font,
                            ),
                          )))
                          .toList(),
                    ]),
                    ...allReports
                        .map((e) => pw.TableRow(children: [
                      pw.Padding(
                          padding: pw.EdgeInsets.all(4),
                          child: pw.Text(
                            (allReports.indexOf(e) + 1).toString(),
                            style: pw.TextStyle(
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold,
                              font: font,
                            ),
                          )),
                      ...e.surveyModel.questions
                          .map((e) => pw.Padding(
                          padding: pw.EdgeInsets.all(4),
                          child: pw.Text(
                            e.answerText,
                            style: pw.TextStyle(
                              fontSize: 20,
                              font: font,
                            ),
                          )))
                          .toList(),
                    ]))
                        .toList(),
                  ]),
            ];
          }));
      pdf.save().then((value) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        Printing.sharePdf(
            bytes: value, filename: 'IkkJutt${surveyModel.title}.pdf');
      });
    });
  }

  @override
  void onInit() {
    getAllReports();
    super.onInit();
  }
}
