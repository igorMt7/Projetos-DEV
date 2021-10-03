// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produtos_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProdutosStore on _ProdutosStoreBase, Store {
  final _$produtosAtom = Atom(name: '_ProdutosStoreBase.produtos');

  @override
  ObservableList<ProdutoStore> get produtos {
    _$produtosAtom.reportRead();
    return super.produtos;
  }

  @override
  set produtos(ObservableList<ProdutoStore> value) {
    _$produtosAtom.reportWrite(value, super.produtos, () {
      super.produtos = value;
    });
  }

  final _$iniciarAsyncAction = AsyncAction('_ProdutosStoreBase.iniciar');

  @override
  Future<List<Produto>> iniciar() {
    return _$iniciarAsyncAction.run(() => super.iniciar());
  }

  final _$deletarAsyncAction = AsyncAction('_ProdutosStoreBase.deletar');

  @override
  Future<dynamic> deletar(int id) {
    return _$deletarAsyncAction.run(() => super.deletar(id));
  }

  final _$_ProdutosStoreBaseActionController =
      ActionController(name: '_ProdutosStoreBase');

  @override
  dynamic atualizarLista(ProdutoStore produto) {
    final _$actionInfo = _$_ProdutosStoreBaseActionController.startAction(
        name: '_ProdutosStoreBase.atualizarLista');
    try {
      return super.atualizarLista(produto);
    } finally {
      _$_ProdutosStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic novo() {
    final _$actionInfo = _$_ProdutosStoreBaseActionController.startAction(
        name: '_ProdutosStoreBase.novo');
    try {
      return super.novo();
    } finally {
      _$_ProdutosStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
produtos: ${produtos}
    ''';
  }
}
