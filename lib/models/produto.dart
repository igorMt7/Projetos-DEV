class Produto {
  int id;
  String nome;
  String descricao;
  String quantidade;
  String imagem;

  Produto(this.nome, this.descricao, this.quantidade, this.imagem);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'quantidade': quantidade,
      'imagem': imagem
    };
    return map;
  }

  Produto.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    descricao = map['descricao'];
    quantidade = map['quantidade'];
    imagem = map['imagem'];
  }
}
