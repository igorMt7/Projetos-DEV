import 'dart:io';

import 'package:meta/meta.dart';
import 'package:partilhe/helpers/enums/tipo_frequencia.dart';
import 'package:partilhe/helpers/value_objects/datetime_value_object.dart';
import 'package:partilhe/local/path_provider/app_path.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PDFRelatorioMediaPresencaEventos {
  static Future<void> criarESalvar({
    @required double media,
    @required String fileName,
  }) async {
    final _basePath = await AppPath.internalAppDocsPath();
    final _path = AppPath.joinPath(pathSnippets: [_basePath, fileName]);
    final file = File(_path);

    final pdf = _gerarPdf(media);
    await file.writeAsBytes(await pdf.save());
  }

  static pw.Document _gerarPdf(double media) {
    final _data = DateTimeValueObject.now().toShortStringDateTime;
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Partilhe'),
                pw.Text(_data),
              ],
            ),
            _linha(),
            pw.Container(
              padding: const pw.EdgeInsets.symmetric(vertical: 8.0),
              alignment: pw.Alignment.centerLeft,
              child: pw.Text('Relatório da média de presenças'),
            ),
            _linha(),
            pw.Column(
              children: [
                pw.Text('Média'),
                pw.Text(media.toString()),
              ],
            ),
          ];
        },
      ),
    );

    return pdf;
  }

  static pw.Widget _linha() {
    return pw.Container(
      margin: const pw.EdgeInsets.only(top: 4.0, bottom: 4.0),
      height: 1.0,
      color: PdfColor.fromHex('#2A3F54'),
    );
  }
}
