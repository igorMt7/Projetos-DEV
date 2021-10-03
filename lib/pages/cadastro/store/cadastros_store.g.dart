// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastros_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CadastrosStore on _CadastrosStoreBase, Store {
  final _$cadastrosAtom = Atom(name: '_CadastrosStoreBase.cadastros');

  @override
  ObservableList<CadastroStore> get cadastros {
    _$cadastrosAtom.reportRead();
    return super.cadastros;
  }

  @override
  set cadastros(ObservableList<CadastroStore> value) {
    _$cadastrosAtom.reportWrite(value, super.cadastros, () {
      super.cadastros = value;
    });
  }

  final _$iniciarAsyncAction = AsyncAction('_CadastrosStoreBase.iniciar');

  @override
  Future<List<Cadastro>> iniciar() {
    return _$iniciarAsyncAction.run(() => super.iniciar());
  }

  final _$deletarAsyncAction = AsyncAction('_CadastrosStoreBase.deletar');

  @override
  Future<dynamic> deletar(int id) {
    return _$deletarAsyncAction.run(() => super.deletar(id));
  }

  final _$_CadastrosStoreBaseActionController =
      ActionController(name: '_CadastrosStoreBase');

  @override
  dynamic atualizarLista(CadastroStore cadastro) {
    final _$actionInfo = _$_CadastrosStoreBaseActionController.startAction(
        name: '_CadastrosStoreBase.atualizarLista');
    try {
      return super.atualizarLista(cadastro);
    } finally {
      _$_CadastrosStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic novo() {
    final _$actionInfo = _$_CadastrosStoreBaseActionController.startAction(
        name: '_CadastrosStoreBase.novo');
    try {
      return super.novo();
    } finally {
      _$_CadastrosStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cadastros: ${cadastros}
    ''';
  }
}
