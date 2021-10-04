// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eventos_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EventosStore on _EventosStoreBase, Store {
  final _$eventosAtom = Atom(name: '_EventosStoreBase.eventos');

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

  final _$iniciarAsyncAction = AsyncAction('_EventosStoreBase.iniciar');

  @override
  Future<List<Evento>> iniciar() {
    return _$iniciarAsyncAction.run(() => super.iniciar());
  }

  final _$deletarAsyncAction = AsyncAction('_EventosStoreBase.deletar');

  @override
  Future<dynamic> deletar(int id) {
    return _$deletarAsyncAction.run(() => super.deletar(id));
  }

  final _$_EventosStoreBaseActionController =
      ActionController(name: '_EventosStoreBase');

  @override
  dynamic atualizarLista(EventoStore evento) {
    final _$actionInfo = _$_EventosStoreBaseActionController.startAction(
        name: '_EventosStoreBase.atualizarLista');
    try {
      return super.atualizarLista(evento);
    } finally {
      _$_EventosStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic novo() {
    final _$actionInfo = _$_EventosStoreBaseActionController.startAction(
        name: '_EventosStoreBase.novo');
    try {
      return super.novo();
    } finally {
      _$_EventosStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
eventos: ${eventos}
    ''';
  }
}
