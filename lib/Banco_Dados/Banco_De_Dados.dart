import 'package:bloco_de_anotacao/Banco_Dados/Listas.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'Tarefa.dart';

class BancoDados {
  static final String nomeTebelaPrincipal = "lista";
  static final String nomeTabelasecundaria = "tarefa";
  static final BancoDados _bancodedados = BancoDados._internal();
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
        "lista_realizada  VARCHAR,"
        "data DATETIME);";
    await db.execute(sql);
    String sql1 =
        "CREATE TABLE $nomeTabelasecundaria("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "id_lista INTEGER NOT NULL,"
        "tarefa VARCHAR,"
        "data DATETIME,"
        "FOREIGN KEY (id_lista) REFERENCES $nomeTebelaPrincipal(id));";
    await db.execute(sql1);
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
    ExcluindotadosTarefas(id);
    return await bancoDados
        .delete(nomeTebelaPrincipal, where: "id = ?", whereArgs: [id]);
  }

  Future<int> SalvarTarefas(Tarefa tarefa) async {
    var bancodados = await db;
    int id = await bancodados.insert(nomeTabelasecundaria, tarefa.toMap());
    return id;
  }

  RecuperaTarefas(int id) async {
    var bancoDados = await db;
    String sql =
        "SELECT * FROM $nomeTabelasecundaria WHERE id_lista = $id ORDER BY data DESC";
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
