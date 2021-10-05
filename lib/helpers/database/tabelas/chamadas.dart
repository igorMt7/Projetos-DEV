import 'campos_tabelas.dart';

class TabelaChamadas {
  static const chamadas = 'CREATE TABLE $chamadasTable(' +
      ' $colCPF INT,' +
      ' $colIdEvento INT,' +
      ' CONSTRAINT pk_chamada PRIMARY KEY ($colCPF, $colIdEvento))';
}
