import 'package:bloco_de_tarefas/shared/model/blocos.dart';
import 'package:bloco_de_tarefas/shared/model/tarefas.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BancoDeDados {
  static final BancoDeDados _bancoDeDados = BancoDeDados._internal();
  Database? _database;
  static final _tablePrimary = "blocos";
  static final _tableSecondary = "tarefas";

  factory BancoDeDados() {
    return _bancoDeDados;
  }

  BancoDeDados._internal();

  get db async {
    if (_database != null) {
      return _database;
    } else {
      _database = await inicialixaDB();
      return _database;
    }
  }

  inicialixaDB() async {
    final caminhaDoBancoDeTarefas = await getDatabasesPath();
    final localBancoDeTarefas =
        join(caminhaDoBancoDeTarefas, "db_blocoDeTarefas.db");
    var db = await openDatabase(localBancoDeTarefas,
        version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    String slqBloco = "CREATE TABLE $_tablePrimary("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "nomeDoBloco VARCHAR,"
        "listaRealizada VARCHAR, "
        "data DATETIME);";
    await db.execute(slqBloco);
    String slqTarefas = "CREATE TABLE $_tableSecondary("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "idBloco INTEGER NOT NULL,"
        "tarefa VARCHAR,"
        "tarefaRealizada VARCHAR, "
        "data DATETIME,"
        "FOREIGN KEY (idBloco) REFERENCES $_tablePrimary (id)"
        "ON DELETE CASCADE);";
    await db.execute(slqTarefas);
  }

  // Primeira tabela

  ///Salvar os dados no banco de dados sqflite
  ///
  /// ser os dados for salvo sera retornado um true;
  /// caso contrario sera retornado um false;
  Future<bool> createBloco(Blocos blocos) async {
    var bancoDados = await db;
    try {
      await bancoDados!.insert(_tablePrimary, blocos.toMap());
      return true;
    } catch (error) {
      return false;
    }
  }

  ///atualiza os dados no banco de dados sqflite
  ///
  /// ser os dados for atualizado sera retornado um true;
  /// caso contrario sera retornado um false;
  Future<bool> updateBloco(Blocos blocos) async {
    var bancoDados = await db;
    try {
      await bancoDados!.update(_tablePrimary, blocos.toMap(),
          where: "id = ?", whereArgs: [blocos.id]);
      return true;
    } catch (error) {
      return false;
    }
  }

  ///recupera os dados no banco de dados sqflite
  ///
  /// ser os dados for recuperado sera retornado uma lista com os dados;
  /// caso contrario sera retornado um null;
  readBloco() async {
    var bancoDados = await db;
    try {
      var lista = await bancoDados!
          .rawQuery("SELECT * FROM $_tablePrimary ORDER BY data DESC");
      return lista;
    } catch (error) {
      return false;
    }
  }

  ///deleta os dados no banco de dados sqflite
  ///
  /// ser os dados for deletado sera retornado um true;
  /// caso contrario sera retornado um false;
  Future<bool> deleteBloco(int id) async {
    var bancoDados = await db;
    try {
      await deleteRefes(id);
      await bancoDados!.delete(_tablePrimary, where: 'id = ?', whereArgs: [id]);
      return true;
    } catch (error) {
      return false;
    }
  }

  // deleta references do primeira tabla na segunda
  Future<bool> deleteRefes(int id) async {
    var bancoDados = await db;
    try {
      await bancoDados!
          .delete(_tableSecondary, where: 'id = ?', whereArgs: [id]);
      return true;
    } catch (error) {
      return false;
    }
  }

  // segunda tabela

  ///Salvar os dados no banco de dados sqflite
  ///
  /// ser os dados for salvo sera retornado um true;
  /// caso contrario sera retornado um false;
  Future<bool> createTarefa(Tarefas tarefas) async {
    var bancoDados = await db;
    try {
      await bancoDados!.insert(_tableSecondary, tarefas.toMap());
      return true;
    } catch (error) {
      return false;
    }
  }

  ///atualiza os dados no banco de dados sqflite
  ///
  /// ser os dados for atualizado sera retornado um true;
  /// caso contrario sera retornado um false;
  Future<bool> updateTarefa(Tarefas tarefas) async {
    var bancoDados = await db;
    try {
      await bancoDados!.update(_tableSecondary, tarefas.toMap(),
          where: "id = ?", whereArgs: [tarefas.id]);
      return true;
    } catch (error) {
      return false;
    }
  }

  ///recupera os dados no banco de dados sqflite
  ///
  /// ser os dados for recuperado sera retornado uma lista com os dados;
  /// caso contrario sera retornado um null;
  readTarefa(int id) async {
    var bancoDados = await db;
    try {
      var lista = await bancoDados!.rawQuery(
          "SELECT * FROM $_tableSecondary WHERE idBloco = $id ORDER BY data DESC");
      return lista;
    } catch (error) {
      return false;
    }
  }

  ///deleta os dados no banco de dados sqflite
  ///
  /// ser os dados for deletado sera retornado um true;
  /// caso contrario sera retornado um false;
  Future<bool> deleteTarefa(int id) async {
    var bancoDados = await db;
    try {
      await bancoDados!
          .delete(_tableSecondary, where: 'id = ?', whereArgs: [id]);
      return true;
    } catch (error) {
      return false;
    }
  }
}
