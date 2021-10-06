// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evento_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EventoStore on _EventoStoreBase, Store {
  final _$idAtom = Atom(name: '_EventoStoreBase.id');

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

  final _$nomeAtom = Atom(name: '_EventoStoreBase.nome');

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

  final _$responsavelAtom = Atom(name: '_EventoStoreBase.responsavel');

  @override
  String get responsavel {
    _$responsavelAtom.reportRead();
    return super.responsavel;
  }

  @override
  set responsavel(String value) {
    _$responsavelAtom.reportWrite(value, super.responsavel, () {
      super.responsavel = value;
    });
  }

  final _$descricaoAtom = Atom(name: '_EventoStoreBase.descricao');

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

  final _$dataAtom = Atom(name: '_EventoStoreBase.data');

  @override
  DateTimeValueObject get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(DateTimeValueObject value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  final _$imagemAtom = Atom(name: '_EventoStoreBase.imagem');

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

  final _$ativoAtom = Atom(name: '_EventoStoreBase.ativo');

  @override
  BoolValueObject get ativo {
    _$ativoAtom.reportRead();
    return super.ativo;
  }

  @override
  set ativo(BoolValueObject value) {
    _$ativoAtom.reportWrite(value, super.ativo, () {
      super.ativo = value;
    });
  }

  final _$salvarAsyncAction = AsyncAction('_EventoStoreBase.salvar');

  @override
  Future<void> salvar() {
    return _$salvarAsyncAction.run(() => super.salvar());
  }

  final _$finalizarAsyncAction = AsyncAction('_EventoStoreBase.finalizar');

  @override
  Future<void> finalizar(int id) {
    return _$finalizarAsyncAction.run(() => super.finalizar(id));
  }

  @override
  String toString() {
    return '''
id: ${id},
nome: ${nome},
responsavel: ${responsavel},
descricao: ${descricao},
data: ${data},
imagem: ${imagem},
ativo: ${ativo}
    ''';
  }
}
