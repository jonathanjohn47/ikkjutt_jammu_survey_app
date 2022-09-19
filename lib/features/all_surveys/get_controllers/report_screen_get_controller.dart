import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/features/all_surveys/models/report_model.dart';
import 'package:ikkjutt_jammu_survey_app/features/new_survey/models/survey_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ReportScreenGetController extends GetxController {
  final SurveyModel surveyModel;

  ReportScreenGetController(this.surveyModel);

  RxList<ReportModel> allReports = <ReportModel>[].obs;

  void getAllReports() {
    ReportModel reportModel = ReportModel.empty();
    for (int i = 0; i < 5; i++) {
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
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(children: [
              pw.Row(children: [
                pw.Image(
                  image,
                ),
                pw.Text(
                  'SURVEY REPORT',
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                    font: font,
                  ),
                ),
              ]),
            ]);
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
