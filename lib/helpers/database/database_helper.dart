import 'dart:async';
import 'dart:io';

import 'package:partilhe/helpers/database/tabelas/cadastro.dart';
import 'package:partilhe/helpers/database/tabelas/campos_tabelas.dart';
import 'package:partilhe/helpers/database/tabelas/chamadas.dart';
import 'package:partilhe/helpers/database/tabelas/evento.dart';
import 'package:partilhe/helpers/database/tabelas/produto.dart';
import 'package:partilhe/models/cadastro.dart';
import 'package:partilhe/models/chamada.dart';
import 'package:partilhe/models/evento.dart';
import 'package:partilhe/models/produto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  //construtor nomeado para criar instância da classe
  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      // executado somente uma vez
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'partlhe.db';

    var cadastrosDatabase = await openDatabase(
      path,
      version: 3,
      onDowngrade: onDatabaseDowngradeDelete,
      onCreate: _createDb,
      onUpgrade: _onUpgrade,
    );
    return cadastrosDatabase;
  }

  Future<void> _createDb(Database db, int newVersion) async {
    await db.execute(TabelaCadastro.cadastro);
    await db.execute(TabelaEvento.evento);
    await db.execute(TabelaProduto.produto);
    await db.execute(TabelaChamadas.chamadas);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute(
          'ALTER TABLE $eventoTable ADD COLUMN $colAtivo BOOLEAN NULL');
    }
  }

//Incluir um objeto cadastro no banco de dados
  Future<int> insertCadastro(Cadastro cadastro) async {
    Database db = await this.database;

    var resultado = await db.insert(cadastroTable, cadastro.toMap());
    return resultado;
  }

//retorna um cadastro pelo id
  Future<Cadastro> getCadastro(int id) async {
    Database db = await this.database;

    List<Map> maps = await db.query(cadastroTable,
        columns: [
          colId,
          colNome,
          colEndereco,
          colTelefone,
          colVeste,
          colEmail,
          colImagem
        ],
        where: "$colId = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Cadastro.fromMap(maps.last);
    } else {
      return null;
    }
  }

  Future<List<Cadastro>> getCadastros() async {
    Database db = await this.database;

    var resultado = await db.query(cadastroTable);

    List<Cadastro> lista = resultado.isNotEmpty
        ? resultado.map((c) => Cadastro.fromMap(c)).toList()
        : [];

    return lista;
  }

  //Atualiza o objeto Cadastro e salva no banco de dados
  Future<int> updateCadastro(Cadastro cadastro) async {
    var db = await this.database;

    var resultado = await db.update(cadastroTable, cadastro.toMap(),
        where: '$colId = ?', whereArgs: [cadastro.id]);

    return resultado;
  }

  //Deleta um objeto Cadastro do banco de dados
  Future<int> deleteCadastro(int id) async {
    var db = await this.database;

    int resultado =
        await db.delete(cadastroTable, where: "$colId = ?", whereArgs: [id]);

    return resultado;
  }

//Pega o número de objetos cadastro no banco de dados
  Future<int> getCountCadastro() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $cadastroTable');

    int resultado = Sqflite.firstIntValue(x);
    return resultado;
  }

  //PRODUTOS
  Future<int> insertProduto(Produto produto) async {
    Database db = await this.database;

    var resultado = await db.insert(produtoTable, produto.toMap());

    return resultado;
  }

//retorna um PRODUTO pelo id
  Future<Produto> getProduto(int id) async {
    Database db = await this.database;

    List<Map> maps = await db.query(produtoTable,
        columns: [colId, colNome, colDescricao, colQuantidade, colImagem],
        where: "$colId = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Produto.fromMap(maps.last);
    } else {
      return null;
    }
  }

  Future<List<Produto>> getProdutos() async {
    Database db = await this.database;

    var resultado = await db.query(produtoTable);

    List<Produto> lista = resultado.isNotEmpty
        ? resultado.map((c) => Produto.fromMap(c)).toList()
        : [];

    return lista;
  }

  //Atualiza o objeto Produto e salva no banco de dados
  Future<int> updateProduto(Produto produto) async {
    var db = await this.database;

    var resultado = await db.update(produtoTable, produto.toMap(),
        where: '$colId = ?', whereArgs: [produto.id]);

    return resultado;
  }

  //Deleta um objeto Produto do banco de dados
  Future<int> deleteProduto(int id) async {
    var db = await this.database;

    int resultado =
        await db.delete(produtoTable, where: "$colId = ?", whereArgs: [id]);

    return resultado;
  }

//Pega o número de objetos cadastro no banco de dados
  Future<int> getCountProduto() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $produtoTable');

    int resultado = Sqflite.firstIntValue(x);
    return resultado;
  }

// EVENTOS
  Future<int> insertEvento(Evento evento) async {
    Database db = await this.database;

    var resultado = await db.insert(eventoTable, evento.toMap());

    return resultado;
  }

//retorna um Evento pelo id
  Future<Evento> getEvento(int id) async {
    Database db = await this.database;

    List<Map> maps = await db.query(eventoTable,
        columns: [
          colId,
          colNome,
          colResponsavel,
          colDescricao,
          colData,
          colImagem
        ],
        where: "$colId = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Evento.fromMap(maps.last);
    } else {
      return null;
    }
  }

  Future<List<Evento>> getEventos() async {
    Database db = await this.database;

    var resultado = await db.query(eventoTable);

    List<Evento> lista = resultado.isNotEmpty
        ? resultado.map((c) => Evento.fromMap(c)).toList()
        : [];

    return lista;
  }

  //Atualizar o objeto Evento e salva no banco de dados
  Future<int> updateEvento(Evento evento) async {
    var db = await this.database;

    var resultado = await db.update(eventoTable, evento.toMap(),
        where: '$colId = ?', whereArgs: [evento.id]);

    return resultado;
  }

  //Deletar um objeto Evento do banco de dados
  Future<int> deleteEvento(int id) async {
    var db = await this.database;

    int resultado =
        await db.delete(eventoTable, where: "$colId = ?", whereArgs: [id]);

    return resultado;
  }

//Obtem o número de objetos Evento no banco de dados
  Future<int> getCountEvento() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $eventoTable');

    int resultado = Sqflite.firstIntValue(x);
    return resultado;
  }

  Future<bool> insertChamada(List<Chamada> chamada) async {
    final sql = 'INSERT INTO chamadas (IdCadastro, IdEvento) VALUES (?, ?)';
    try {
      Database db = await this.database;
      if (chamada.isNotEmpty) {
        await db.transaction((txn) async {
          final batch = txn.batch();
          chamada.forEach((e) {
            batch.rawInsert(sql, [e.idCadastro, e.idEvento]);
          });
          await batch.commit(noResult: true);
        });
        return true;
      }
      return false;
    } on DatabaseException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  Future close() async {
    Database db = await this.database;
    db.close();
  }
}
