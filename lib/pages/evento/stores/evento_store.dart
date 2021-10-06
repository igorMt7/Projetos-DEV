import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:partilhe/helpers/database/database_helper.dart';
import 'package:partilhe/helpers/value_objects/bool_value_object.dart';
import 'package:partilhe/helpers/value_objects/datetime_value_object.dart';
import 'package:partilhe/models/evento.dart';
import 'package:partilhe/pages/evento/stores/eventos_store.dart';
import 'package:partilhe/pages/evento_finalizado/stores/eventos_finalizados_store.dart';
part 'evento_store.g.dart';

EventoStore eventoStoreFromModel(Evento model) => EventoStore(
      id: model.id,
      nome: model.nome,
      responsavel: model.responsavel,
      descricao: model.descricao,
      data: model.data,
      imagem: model.imagem,
      ativo: model.ativo,
    );

class EventoStore = _EventoStoreBase with _$EventoStore;

abstract class _EventoStoreBase with Store {
  final _db = GetIt.I<DatabaseHelper>();

  _EventoStoreBase({
    this.id,
    this.nome,
    this.responsavel,
    this.descricao,
    this.data,
    this.imagem,
    this.ativo,
  });

  @observable
  int id;

  @observable
  String nome;

  @observable
  String responsavel;

  @observable
  String descricao;

  @observable
  DateTimeValueObject data;

  @observable
  String imagem;

  @observable
  BoolValueObject ativo;

  @action
  Future<void> salvar() async {
    if (id != null && id > 0) {
      await _db.updateEvento(this.toModel());
    } else {
      final id = await _db.insertEvento(this.toModel());
      this.id = id;
    }
    GetIt.I.get<EventosStore>().atualizarLista(this);
  }

  @action
  Future<void> finalizar(int id) async {
    if (id != null && id > 0) {
      this.ativo = BoolValueObject.fromBool(false);
      await _db.finalizarEvento(id);
      GetIt.I.get<EventosStore>().atualizarLista(this);
      GetIt.I.get<EventosFinalizadosStore>().atualizarLista(this);
    }
  }

  Evento toModel() => Evento(nome, responsavel, descricao, data, imagem, ativo);
}
