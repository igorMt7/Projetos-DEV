// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CadastroStore on _CadastroStoreBase, Store {
  final _$idAtom = Atom(name: '_CadastroStoreBase.id');

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

  final _$nomeAtom = Atom(name: '_CadastroStoreBase.nome');

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

  final _$enderecoAtom = Atom(name: '_CadastroStoreBase.endereco');

  @override
  String get endereco {
    _$enderecoAtom.reportRead();
    return super.endereco;
  }

  @override
  set endereco(String value) {
    _$enderecoAtom.reportWrite(value, super.endereco, () {
      super.endereco = value;
    });
  }

  final _$telefoneAtom = Atom(name: '_CadastroStoreBase.telefone');

  @override
  String get telefone {
    _$telefoneAtom.reportRead();
    return super.telefone;
  }

  @override
  set telefone(String value) {
    _$telefoneAtom.reportWrite(value, super.telefone, () {
      super.telefone = value;
    });
  }

  final _$vesteAtom = Atom(name: '_CadastroStoreBase.veste');

  @override
  String get veste {
    _$vesteAtom.reportRead();
    return super.veste;
  }

  @override
  set veste(String value) {
    _$vesteAtom.reportWrite(value, super.veste, () {
      super.veste = value;
    });
  }

  final _$emailAtom = Atom(name: '_CadastroStoreBase.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$imagemAtom = Atom(name: '_CadastroStoreBase.imagem');

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

  final _$isCheckedAtom = Atom(name: '_CadastroStoreBase.isChecked');

  @override
  bool get isChecked {
    _$isCheckedAtom.reportRead();
    return super.isChecked;
  }

  @override
  set isChecked(bool value) {
    _$isCheckedAtom.reportWrite(value, super.isChecked, () {
      super.isChecked = value;
    });
  }

  final _$salvarAsyncAction = AsyncAction('_CadastroStoreBase.salvar');

  @override
  Future<void> salvar() {
    return _$salvarAsyncAction.run(() => super.salvar());
  }

  final _$_CadastroStoreBaseActionController =
      ActionController(name: '_CadastroStoreBase');

  @override
  dynamic check() {
    final _$actionInfo = _$_CadastroStoreBaseActionController.startAction(
        name: '_CadastroStoreBase.check');
    try {
      return super.check();
    } finally {
      _$_CadastroStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
id: ${id},
nome: ${nome},
endereco: ${endereco},
telefone: ${telefone},
veste: ${veste},
email: ${email},
imagem: ${imagem},
isChecked: ${isChecked}
    ''';
  }
}
