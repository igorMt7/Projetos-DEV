class Cadastro {
  int id;
  String nome;
  String endereco;
  String telefone;
  String veste;
  String email;
  String imagem;

  Cadastro(
    this.nome,
    this.endereco,
    this.telefone,
    this.veste,
    this.email,
    this.imagem,
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'nome': nome,
      'endereco': endereco,
      'telefone': telefone,
      'veste': veste,
      'email': email,
      'imagem': imagem
    };
    return map;
  }

  Cadastro.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    endereco = map['endereco'];
    telefone = map['telefone'];
    veste = map['veste'];
    email = map['email'];
    imagem = map['imagem'];
  }
}
