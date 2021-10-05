class Chamada {
  int id;
  int idCadastro;
  int idEvento;

  Chamada(this.idCadastro, this.idEvento);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'idCadastro': idCadastro,
      'idEvento': idEvento,
    };
    return map;
  }

  Chamada.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    idCadastro = map['idCadastro'];
    idEvento = map['idEvento'];
  }
}
