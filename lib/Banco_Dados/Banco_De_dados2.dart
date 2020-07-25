import 'package:bloco_de_anotacao/Banco_Dados/Tarefa.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BancoDados2 {
  static final String nomeTabelasecundaria = "tarefa";
  static final BancoDados2 _bancodedados = BancoDados2._internal();
  Database _database;

  factory BancoDados2() {
    return _bancodedados;
  }

  BancoDados2._internal() {}

  get db async {
    if (_database != null) {
      return _database;
    } else {
      _database = await inicialixaDB();
      return _database;
    }
  }

  _onCreate(Database db, int version) async {
    String sql = "CREATE TABLE $nomeTabelasecundaria("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "id_lista INTEGER,"
        "tarefa TEXT,"
        "data DATETIME);";
    await db.execute(sql);
  }

  inicialixaDB() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "db_anotacoes2.db");
    var db =
        await openDatabase(localBancoDados, version: 3, onCreate: _onCreate);
    return db;
  }

  Future<int> SalvarTarefas(Tarefa tarefa) async {
    var bancodados = await db;
    int id = await bancodados.insert(nomeTabelasecundaria, tarefa.toMap());
    return id;
  }

  RecuperaTarefas(int id) async {
    var bancoDados = await db;
    String sql =
        "SELECT * FROM $nomeTabelasecundaria  ORDER BY data DESC";
    List tarefa = await bancoDados.rawQuery(sql);
    return tarefa;
  }

  Future<int> AtualizarTarefa(Tarefa tarefa) async {
    var bancoDados = await db;
    return await bancoDados.update(nomeTabelasecundaria, tarefa.toMap(),
        where: "id = ?", whereArgs: [tarefa.id]);
  }

  Future<int> ExcluindoTarefas(int id) async {
    var bancoDados = await db;
    return await bancoDados
        .delete(nomeTabelasecundaria, where: "id = ?", whereArgs: [id]);
  }
  Future<int> ExcluindotadosTarefas(int id) async {
    var bancoDados = await db;
    return await bancoDados
        .delete(nomeTabelasecundaria, where: "id_lista = ?", whereArgs: [id]);
  }
}
