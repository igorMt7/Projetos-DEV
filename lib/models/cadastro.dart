import 'package:partilhe/helpers/value_objects/bool_value_object.dart';

class Cadastro {
  String nome;
  String endereco;
  String telefone;
  String veste;
  String email;
  String imagem;
  String cpf;
  String dependentes;
  BoolValueObject empregoFixo;

  Cadastro(
    this.nome,
    this.endereco,
    this.telefone,
    this.veste,
    this.email,
    this.imagem,
    this.cpf,
    this.dependentes,
    this.empregoFixo,
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'nome': nome,
      'endereco': endereco,
      'telefone': telefone,
      'veste': veste,
      'email': email,
      'imagem': imagem,
      'cpf': cpf,
      'dependentes': dependentes,
      'empregoFixo': empregoFixo.toBool
    };
    return map;
  }

  Cadastro.fromMap(Map<String, dynamic> map) {
    nome = map['nome'];
    endereco = map['endereco'];
    telefone = map['telefone'];
    veste = map['veste'];
    email = map['email'];
    imagem = map['imagem'];
    cpf = map['cpf'];
    dependentes = map['dependentes'];
    empregoFixo = BoolValueObject.fromDynamic(map['empregoFixo']);
  }
}
