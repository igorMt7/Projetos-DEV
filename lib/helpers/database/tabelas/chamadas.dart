import 'campos_tabelas.dart';

class TabelaChamadas {
  static const chamadas = 'CREATE TABLE $chamadasTable(' +
      ' $colCPF TEXT,' +
      ' $colIdEvento INT,' +
      ' CONSTRAINT pk_chamada PRIMARY KEY ($colCPF, $colIdEvento))';
}
