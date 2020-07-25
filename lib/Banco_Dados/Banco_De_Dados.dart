import 'package:bloco_de_anotacao/Banco_Dados/Listas.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'Banco_De_dados2.dart';

class BancoDados {
  static final String nomeTebelaPrincipal = "lista";
  static final String nomeTabelasecundaria = "tarefa";
  static final BancoDados _bancodedados = BancoDados._internal();
  var dbTarefa = BancoDados2();
  Database _database;

  factory BancoDados() {
    return _bancodedados;
  }

  BancoDados._internal() {}

  get db async {
    if (_database != null) {
      return _database;
    } else {
      _database = await inicialixaDB();
      return _database;
    }
  }

  _onCreate(Database db, int version) async {
    String sql = "CREATE TABLE $nomeTebelaPrincipal("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "titulo VARCHAR,"
        "data DATETIME);"
        "CREATE TABLE $nomeTabelasecundaria("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "id_lista INTEGER,"
        "tarefa TEXT,"
        "data DATETIME,"
        "FOREIGN KEY (id_lista) REFERENCES $nomeTebelaPrincipal(id));";
    await db.execute(sql);
  }

  inicialixaDB() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "db_anotacoes.db");
    var db =
        await openDatabase(localBancoDados, version: 3, onCreate: _onCreate);
    return db;
  }

  Future<int> SalvarLista(Lista lista) async {
    var bancoDados = await db;
    int id = await bancoDados.insert(nomeTebelaPrincipal, lista.toMap());
    return id;
  }


  RecuperaListas() async {
    var bancoDados = await db;
    String sql = "SELECT * FROM $nomeTebelaPrincipal ORDER BY data DESC";
    List anotacao = await bancoDados.rawQuery(sql);
    return anotacao;
  }

  Future<int> AtualizandoLista(Lista lista) async {
    var bancodados = await db;
    return await bancodados.update(nomeTebelaPrincipal, lista.toMap(),
        where: "id = ?", whereArgs: [lista.id]);
  }

  Future<int> ExcluindoLista(int id) async {
    var bancoDados = await db;
    dbTarefa.ExcluindotadosTarefas(id);
    return await bancoDados
        .delete(nomeTebelaPrincipal, where: "id = ?", whereArgs: [id]);
  }

}
