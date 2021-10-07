import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:partilhe/helpers/database/database_helper.dart';
import 'package:partilhe/models/chamada.dart';
import 'package:partilhe/pages/cadastro/stores/cadastros_store.dart';

part 'chamada_store.g.dart';

class ChamadaStore = _ChamadaStoreBase with _$ChamadaStore;

abstract class _ChamadaStoreBase with Store {
  final _db = GetIt.I<DatabaseHelper>();
  final cadastrosStore = GetIt.I<CadastrosStore>();

  @action
  Future<bool> iniciarChamada(int idEvento) async {
    final chamada = await _db.getChamada(idEvento);
    if (chamada.isNotEmpty) {
      chamada.forEach((chamada) {
        final cadastro = cadastrosStore.cadastros.firstWhere(
            (cadastro) => cadastro.cpf == chamada,
            orElse: () => null);
        if (cadastro != null) cadastro.isChecked = true;
      });
    } else {
      await cadastrosStore.iniciar();
    }

    return true;
  }

  @action
  Future<bool> salvarChamada(int idEvento) async {
    List<Chamada> listaPresentes = [];

    if (cadastrosStore.cadastros.isNotEmpty) {
      cadastrosStore.cadastros.forEach((e) {
        if (e.isChecked) listaPresentes.add(Chamada(e.cpf, idEvento));
      });
    }

    if (listaPresentes.isNotEmpty) {
      return await _db.insertChamada(listaPresentes);
    }

    return false;
  }
}
