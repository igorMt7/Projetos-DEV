import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:partilhe/app.router.dart';
import 'package:partilhe/helpers/database/database_helper.dart';
import 'package:partilhe/helpers/value_objects/bool_value_object.dart';
import 'package:partilhe/helpers/value_objects/datetime_value_object.dart';
import 'package:partilhe/models/evento.dart';
import 'package:partilhe/pages/evento/stores/evento_store.dart';
import 'package:partilhe/routes/rotas.dart';
part 'eventos_store.g.dart';

class EventosStore = _EventosStoreBase with _$EventosStore;

abstract class _EventosStoreBase with Store {
  final _db = GetIt.I<DatabaseHelper>();

  _EventosStoreBase() {
    iniciar();
  }

  @observable
  ObservableList<EventoStore> eventos = ObservableList<EventoStore>();

  @action
  Future<List<Evento>> iniciar() async {
    final response = await _db.getEventos(ativo: true);
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

    if (!evento.ativo.toBool)
      return;
    else
      eventos.insert(index, evento);
  }

  @action
  Future deletar(int id) async {
    if (id != null || id > 0) {
      final response = await _db.deleteEvento(id);
      if (response == 1) eventos.removeWhere((e) => e.id == id);
    }
  }

  @action
  novo() {
    AppRouter.gotoParams(
      nomeRota: rotaEvento,
      parametros: EventoStore(
        id: null,
        nome: '',
        descricao: '',
        responsavel: '',
        imagem: null,
        ativo: BoolValueObject.fromBool(true),
        data: DateTimeValueObject.now(),
      ),
    );
  }
}
