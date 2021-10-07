class RelatorioFrequencia {
  RelatorioFrequencia({
    this.cpf,
    this.nome,
    this.frequencia,
  });

  String cpf;
  String nome;
  int frequencia;

  factory RelatorioFrequencia.fromMap(Map<String, dynamic> map) =>
      RelatorioFrequencia(
        cpf: map['cpf'],
        nome: map['nome'],
        frequencia: map['frequencia'],
      );
}
