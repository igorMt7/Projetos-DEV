import './campos_tabelas.dart';

class TabelaCadastro {
  static const cadastro = 'CREATE TABLE $cadastroTable (' +
      ' $colCPF TEXT PRIMARY KEY,' +
      ' $colNome TEXT,' +
      ' $colEndereco TEXT,' +
      ' $colTelefone TEXT,' +
      ' $colVeste TEXT,' +
      ' $colEmail TEXT,' +
      ' $colImagem TEXT,' +
      ' $colDependentes INTEGER default 0,' +
      ' $colEmpregoFixo BOOLEAN default 0)';
}
