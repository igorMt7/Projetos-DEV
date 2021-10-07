import 'dart:io';

import 'package:meta/meta.dart';
import 'package:partilhe/helpers/enums/tipo_frequencia.dart';
import 'package:partilhe/helpers/value_objects/datetime_value_object.dart';
import 'package:partilhe/local/path_provider/app_path.dart';
import 'package:partilhe/models/relatorios/maior_frequencia.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PDFRelatorioFrequencia {
  static Future<void> criarESalvar({
    @required List<RelatorioFrequencia> listaFrequencia,
    @required String fileName,
    @required TIPO_FREQUENCIA tipo,
  }) async {
    final _basePath = await AppPath.internalAppDocsPath();
    final _path = AppPath.joinPath(pathSnippets: [_basePath, fileName]);
    final file = File(_path);

    final pdf = _gerarPdf(listaFrequencia, tipo);
    await file.writeAsBytes(await pdf.save());
  }

  static pw.Document _gerarPdf(
    List<RelatorioFrequencia> listaFrequencia,
    TIPO_FREQUENCIA tipo,
  ) {
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
              child: pw.Text(
                  '${tipo == TIPO_FREQUENCIA.MAIOR ? 'Relatório 30 maiores frequências' : 'Relatório 30 menores frequências'}'),
            ),
            _linha(),
            _cabecalhosLista(),
            _listaFrequencia(listaFrequencia),
          ];
        },
      ),
    );

    return pdf;
  }

  static pw.Widget _cabecalhosLista() {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(vertical: 4.0),
      child: pw.Row(children: [
        pw.Expanded(
          flex: 1,
          child: pw.Container(
            alignment: pw.Alignment.centerLeft,
            child: pw.Text('CPF',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ),
        ),
        pw.Expanded(
          flex: 3,
          child: pw.Container(
            alignment: pw.Alignment.centerLeft,
            child: pw.Text('NOME',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ),
        ),
        pw.Expanded(
          flex: 1,
          child: pw.Container(
            alignment: pw.Alignment.center,
            child: pw.Text('FREQUÊNCIA',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ),
        ),
      ]),
    );
  }

  static pw.Widget _listaFrequencia(List<RelatorioFrequencia> listaFrequencia) {
    List<pw.Widget> _linhas = [];

    listaFrequencia?.forEach((cadastro) {
      _linhas.add(
        pw.Padding(
          padding: const pw.EdgeInsets.all(4.0),
          child: pw.Row(children: [
            pw.Expanded(
              flex: 1,
              child: pw.Container(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(cadastro.cpf),
              ),
            ),
            pw.Expanded(
              flex: 3,
              child: pw.Container(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(cadastro.nome ?? 'N/D'),
              ),
            ),
            pw.Expanded(
              flex: 1,
              child: pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Text(cadastro.frequencia?.toString() ?? 'N/D'),
              ),
            ),
          ]),
        ),
      );
    });

    return pw.Column(children: _linhas);
  }

  static pw.Widget _linha() {
    return pw.Container(
      margin: const pw.EdgeInsets.only(top: 4.0, bottom: 4.0),
      height: 1.0,
      color: PdfColor.fromHex('#2A3F54'),
    );
  }
}
