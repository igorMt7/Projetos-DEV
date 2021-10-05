class Chamada {
  String cpf;
  int idEvento;

  Chamada(this.cpf, this.idEvento);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'cpf': cpf,
      'idEvento': idEvento,
    };
    return map;
  }

  Chamada.fromMap(Map<String, dynamic> map) {
    cpf = map['cpf'];
    idEvento = map['idEvento'];
  }
}
