import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:partilhe/helpers/database/database_helper.dart';
import 'package:partilhe/helpers/enums/tipo_frequencia.dart';
import 'package:partilhe/helpers/value_objects/datetime_value_object.dart';
import 'package:partilhe/local/path_provider/app_path.dart';
import 'package:partilhe/pages/cadastro/stores/cadastros_store.dart';
import 'package:partilhe/pages/relatorios/relatorio-pdf/dependentes/relatorio-dependentes.dart';
import 'package:partilhe/pages/relatorios/relatorio-pdf/frequencia/relatorio-frequencia.dart';
import 'package:partilhe/pages/relatorios/relatorio-pdf/media_presenca_eventos/media_presenca_eventos.dart';
import 'package:partilhe/pages/relatorios/relatorio-pdf/tamanho_roupa/tamanho_roupa.dart';
import 'package:share/share.dart';
part 'relatorios_store.g.dart';

class RelatoriosStore = _RelatoriosStoreBase with _$RelatoriosStore;

abstract class _RelatoriosStoreBase with Store {
  final _db = GetIt.I<DatabaseHelper>();
  final _data = DateTimeValueObject.now()
      .toLongStringDateTimeFormatedHourWithMs
      .replaceAll('/', '-');

  Future frequencia(TIPO_FREQUENCIA tipo) async {
    final listaFrequencia = await _db.getFrequencia(tipo);

    if (listaFrequencia != null && listaFrequencia.isNotEmpty) {
      final _pathBase = await AppPath.internalAppDocsPath();
      final _fileName = 'relatorio_frequencia_$_data.pdf';

      final _path = AppPath.joinPath(pathSnippets: [_pathBase, _fileName]);

      await PDFRelatorioFrequencia.criarESalvar(
        listaFrequencia: listaFrequencia,
        fileName: _fileName,
        tipo: tipo,
      );
      await Share.shareFiles([_path]);
    }
  }

  Future dependentes() async {
    final cadastros = GetIt.I<CadastrosStore>().cadastros;

    cadastros.sort((a, b) => b.dependentes.compareTo(a.dependentes));

    if (cadastros != null && cadastros.isNotEmpty) {
      final _pathBase = await AppPath.internalAppDocsPath();
      final _fileName = 'relatorio_dependentes_$_data.pdf';

      final _path = AppPath.joinPath(pathSnippets: [_pathBase, _fileName]);

      await PDFRelatorioDependentes.criarESalvar(
          cadastros: cadastros.toList(), fileName: _fileName);
      await Share.shareFiles([_path]);
    }
  }

  Future tamanhoRoupa() async {
    final cadastros = GetIt.I<CadastrosStore>().cadastros;

    cadastros.sort((a, b) => b.veste.compareTo(a.veste));

    if (cadastros != null && cadastros.isNotEmpty) {
      final _pathBase = await AppPath.internalAppDocsPath();
      final _fileName = 'relatorio_tamanho_roupa_$_data.pdf';

      final _path = AppPath.joinPath(pathSnippets: [_pathBase, _fileName]);

      await PDFRelatorioTamanhoRoupa.criarESalvar(
          cadastros: cadastros.toList(), fileName: _fileName);
      await Share.shareFiles([_path]);
    }
  }

  Future mediaPresencaEventos() async {
    final media = await _db.getMediaEvento();

    if (media != null) {
      final _pathBase = await AppPath.internalAppDocsPath();
      final _fileName = 'relatorio_media_presenca_eventos_$_data.pdf';

      final _path = AppPath.joinPath(pathSnippets: [_pathBase, _fileName]);

      await PDFRelatorioMediaPresencaEventos.criarESalvar(
        media: media,
        fileName: _fileName,
      );
      await Share.shareFiles([_path]);
    }
  }
}
