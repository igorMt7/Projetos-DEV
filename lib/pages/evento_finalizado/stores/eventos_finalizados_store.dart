import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:partilhe/helpers/database/database_helper.dart';
import 'package:partilhe/models/evento.dart';
import 'package:partilhe/pages/evento/stores/evento_store.dart';
part 'eventos_finalizados_store.g.dart';

class EventosFinalizadosStore = _EventosFinalizadosStoreBase
    with _$EventosFinalizadosStore;

abstract class _EventosFinalizadosStoreBase with Store {
  final _db = GetIt.I<DatabaseHelper>();

  _EventosFinalizadosStoreBase() {
    iniciar();
  }

  @observable
  ObservableList<EventoStore> eventos = ObservableList<EventoStore>();

  @action
  Future<List<Evento>> iniciar() async {
    final response = await _db.getEventos(ativo: false);
    if (response != null) {
      response.forEach((e) {
        eventos.add(eventoStoreFromModel(e));
      });
      return response;
    }
    return null;
  }

  @action
  atualizarLista(EventoStore evento) {
    int index = eventos.indexWhere((e) => e.id == evento.id);
    if (index < 0) {
      index = 0;
    } else {
      eventos.removeAt(index);
    }

    eventos.insert(index, evento);
  }
}
