class Evento {
  int id;
  String nome;
  String responsavel;
  String descricao;
  String data;
  String imagem;

  Evento(this.nome, this.responsavel, this.descricao, this.data, this.imagem);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'nome': nome,
      'responsavel': responsavel,
      'descricao': descricao,
      'data': data,
      'imagem': imagem,
    };
    return map;
  }

  Evento.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    responsavel = map['responsavel'];
    descricao = map['descricao'];
    data = map['data'];
    imagem = map['imagem'];
  }
}
