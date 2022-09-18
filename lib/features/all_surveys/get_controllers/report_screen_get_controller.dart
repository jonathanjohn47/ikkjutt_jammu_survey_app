import 'dart:io';

import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/features/all_surveys/models/report_model.dart';
import 'package:ikkjutt_jammu_survey_app/features/new_survey/models/survey_model.dart';
import 'package:path_provider/path_provider.dart';
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
      allReports.add(reportModel);
    }
  }

  Future<void> saveAsPdf() async {
    final font = await PdfGoogleFonts.nunitoExtraLight();

    ByteData bytes = await rootBundle.load('assets/images/logo.jpeg');
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Row(children: [
            pw.Image(
              pw.MemoryImage(bytes.buffer.asUint8List()),
            ),
            pw.Text("Ikkjutt Jammu Survey No. ${surveyModel.id}",
                style: pw.TextStyle(
                  font: font,
                )),
          ]); // Center
        },
      ),
    );
    final output = await getTemporaryDirectory();
    final path = "${output!.path}/IkkJuttSurvey.pdf";
    File(path).create(recursive: true).then((file) async {
      await file.writeAsBytes(await pdf.save());
      print("Output path: $path");
      print("File Saved");
    });
  }

  @override
  void onInit() {
    getAllReports();
    super.onInit();
  }
}
