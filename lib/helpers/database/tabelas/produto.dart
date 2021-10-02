import 'campos_tabelas.dart';

class TabelaProduto {
  static const produto = 'CREATE TABLE $produtoTable(' +
      ' $colId INTEGER PRIMARY KEY AUTOINCREMENT,' +
      ' $colNome TEXT,' +
      ' $colDescricao TEXT,' +
      ' $colQuantidade TEXT,' +
      ' $colImagem TEXT)';
}
