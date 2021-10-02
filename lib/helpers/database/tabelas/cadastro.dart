import './campos_tabelas.dart';

class TabelaCadastro {
  static const cadastro = 'CREATE TABLE $cadastroTable (' +
      ' $colId INTEGER PRIMARY KEY AUTOINCREMENT,' +
      ' $colNome TEXT,' +
      ' $colEndereco TEXT,' +
      ' $colTelefone TEXT,' +
      ' $colVeste TEXT,' +
      ' $colEmail TEXT,' +
      ' $colImagem TEXT)';
}
