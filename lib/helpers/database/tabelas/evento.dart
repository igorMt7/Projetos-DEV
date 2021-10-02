import './campos_tabelas.dart';

class TabelaEvento {
  static const evento = 'CREATE TABLE $eventoTable(' +
      ' $colId INTEGER PRIMARY KEY AUTOINCREMENT,' +
      ' $colNome TEXT,' +
      ' $colResponsavel TEXT,' +
      ' $colDescricao TEXT,' +
      ' $colData TEXT,' +
      ' $colImagem TEXT,' +
      ' $colAtivo BOOLEAN NULL)';
}
