// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produto_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProdutoStore on _ProdutoStoreBase, Store {
  final _$idAtom = Atom(name: '_ProdutoStoreBase.id');

  @override
  int get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(int value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  final _$nomeAtom = Atom(name: '_ProdutoStoreBase.nome');

  @override
  String get nome {
    _$nomeAtom.reportRead();
    return super.nome;
  }

  @override
  set nome(String value) {
    _$nomeAtom.reportWrite(value, super.nome, () {
      super.nome = value;
    });
  }

  final _$descricaoAtom = Atom(name: '_ProdutoStoreBase.descricao');

  @override
  String get descricao {
    _$descricaoAtom.reportRead();
    return super.descricao;
  }

  @override
  set descricao(String value) {
    _$descricaoAtom.reportWrite(value, super.descricao, () {
      super.descricao = value;
    });
  }

  final _$quantidadeAtom = Atom(name: '_ProdutoStoreBase.quantidade');

  @override
  String get quantidade {
    _$quantidadeAtom.reportRead();
    return super.quantidade;
  }

  @override
  set quantidade(String value) {
    _$quantidadeAtom.reportWrite(value, super.quantidade, () {
      super.quantidade = value;
    });
  }

  final _$imagemAtom = Atom(name: '_ProdutoStoreBase.imagem');

  @override
  String get imagem {
    _$imagemAtom.reportRead();
    return super.imagem;
  }

  @override
  set imagem(String value) {
    _$imagemAtom.reportWrite(value, super.imagem, () {
      super.imagem = value;
    });
  }

  final _$salvarAsyncAction = AsyncAction('_ProdutoStoreBase.salvar');

  @override
  Future<void> salvar() {
    return _$salvarAsyncAction.run(() => super.salvar());
  }

  @override
  String toString() {
    return '''
id: ${id},
nome: ${nome},
descricao: ${descricao},
quantidade: ${quantidade},
imagem: ${imagem}
    ''';
  }
}
