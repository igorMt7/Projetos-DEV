import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:partilhe/helpers/database/database_helper.dart';
import 'package:partilhe/pages/cadastro/stores/cadastros_store.dart';
part 'chamada_finalizada_store.g.dart';

class ChamadaFinalizadaStore = _ChamadaFinalizadaStoreBase
    with _$ChamadaFinalizadaStore;

abstract class _ChamadaFinalizadaStoreBase with Store {
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
}
