import 'package:partilhe/helpers/value_objects/bool_value_object.dart';
import 'package:partilhe/helpers/value_objects/datetime_value_object.dart';
import 'package:partilhe/helpers/verifica_nulo_vazio.dart';

class Evento {
  int id;
  String nome;
  String responsavel;
  String descricao;
  DateTimeValueObject data;
  String imagem;
  BoolValueObject ativo;

  Evento(
    this.nome,
    this.responsavel,
    this.descricao,
    this.data,
    this.imagem,
    this.ativo,
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'nome': nome,
      'responsavel': responsavel,
      'descricao': descricao,
      'data': data?.toLongStringDateTime,
      'imagem': imagem,
      'ativo': ativo.toInt,
    };
    return map;
  }

  Evento.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    responsavel = map['responsavel'];
    descricao = map['descricao'];
    data = !VerificaNuloVazio.ehNuloOuVazio(map['data'])
        ? DateTimeValueObject.fromString(map['data'])
        : null;
    imagem = map['imagem'];
    ativo = BoolValueObject.fromDynamic(map['ativo']);
  }
}
