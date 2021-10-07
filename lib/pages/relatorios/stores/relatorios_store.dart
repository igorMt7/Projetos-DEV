import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:partilhe/helpers/database/database_helper.dart';
import 'package:partilhe/helpers/enums/tipo_frequencia.dart';
import 'package:partilhe/helpers/value_objects/datetime_value_object.dart';
import 'package:partilhe/local/path_provider/app_path.dart';
import 'package:partilhe/pages/relatorios/relatorio-pdf/frequencia/relatorio-frequencia.dart';
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
}
