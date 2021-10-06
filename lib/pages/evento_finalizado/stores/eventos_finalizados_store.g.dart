// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eventos_finalizados_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EventosFinalizadosStore on _EventosFinalizadosStoreBase, Store {
  final _$eventosAtom = Atom(name: '_EventosFinalizadosStoreBase.eventos');

  @override
  ObservableList<EventoStore> get eventos {
    _$eventosAtom.reportRead();
    return super.eventos;
  }

  @override
  set eventos(ObservableList<EventoStore> value) {
    _$eventosAtom.reportWrite(value, super.eventos, () {
      super.eventos = value;
    });
  }

  final _$iniciarAsyncAction =
      AsyncAction('_EventosFinalizadosStoreBase.iniciar');

  @override
  Future<List<Evento>> iniciar() {
    return _$iniciarAsyncAction.run(() => super.iniciar());
  }

  final _$_EventosFinalizadosStoreBaseActionController =
      ActionController(name: '_EventosFinalizadosStoreBase');

  @override
  dynamic atualizarLista(EventoStore evento) {
    final _$actionInfo = _$_EventosFinalizadosStoreBaseActionController
        .startAction(name: '_EventosFinalizadosStoreBase.atualizarLista');
    try {
      return super.atualizarLista(evento);
    } finally {
      _$_EventosFinalizadosStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
eventos: ${eventos}
    ''';
  }
}
