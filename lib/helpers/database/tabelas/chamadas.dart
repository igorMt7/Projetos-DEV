import 'campos_tabelas.dart';

class TabelaChamadas {
  static const chamadas = 'CREATE TABLE $chamadasTable(' +
      ' $colId INTEGER PRIMARY KEY AUTOINCREMENT,' +
      ' $colIdCadastro INT,' +
      ' $colIdEvento INT)';
}
