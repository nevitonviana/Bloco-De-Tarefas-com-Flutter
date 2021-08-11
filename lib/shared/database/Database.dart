import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BancoDeDados {
  static final BancoDeDados _bancoDeDados = BancoDeDados._internal();
  Database? _database;

  factory BancoDeDados() {
    return _bancoDeDados;
  }

  BancoDeDados._internal();

  get db async {
    if (_database != null) {
      return _database;
    } else {
      _database = await inicialixaDB();
    }
  }

  inicialixaDB() async {
    final caminhaDoBancoDeDados = await getDatabasesPath();
    final localBancoDeDados = join(caminhaDoBancoDeDados, "db_blocoDeDados.db");
    var db =
        await openDatabase(localBancoDeDados, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    String slqBloco = "CREATE TABLE blocos("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "bloco VARCHAR,"
        "listaRealizada VARCHAR, "
        "data DATETIME);";
    await db.execute(slqBloco);
    String slqTarefas= "CREATE TABLE tarefas("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "id_bloco INTEGER NOT NULL,"
        "tarefa VARCHAR,"
        "tarefaRealizada VARCHAR, "
        "data DATETIME,"
        "FOREIGN KEY (id_bloco) REFERENCES bloco(id)"
        "ON DELETE CASCADE,"
        "PRAGMA foreign_keys = ON);";
    await db.execute(slqTarefas);
  }
}
