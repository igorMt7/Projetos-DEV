import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:partilhe/helpers/database/database_helper.dart';
import 'package:partilhe/models/chamada.dart';
import 'package:partilhe/pages/cadastro/stores/cadastros_store.dart';

part 'chamada_store.g.dart';

class ChamadaStore = _ChamadaStoreBase with _$ChamadaStore;

abstract class _ChamadaStoreBase with Store {
  final _db = GetIt.I<DatabaseHelper>();

  @action
  Future<bool> salvarChamada(int idEvento) async {
    final cadastrosStore = GetIt.I<CadastrosStore>();

    List<Chamada> listaPresentes = [];

    if (cadastrosStore.cadastros.isNotEmpty) {
      cadastrosStore.cadastros.forEach((e) {
        if (e.isChecked) listaPresentes.add(Chamada(e.id, idEvento));
      });
    }

    if (listaPresentes.isNotEmpty) {
      return await _db.insertChamada(listaPresentes);
    }

    return false;
  }
}
