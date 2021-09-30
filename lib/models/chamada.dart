class Chamada {
  int id;
  String idCadastro;
  String idEvento;
  bool checked;

  Chamada(this.idCadastro, this.idEvento, {this.checked = false});

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
