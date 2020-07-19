import 'package:bloco_de_anotacao/Banco_Dados/Listas.dart';
import 'package:bloco_de_anotacao/Banco_Dados/Tarefa.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
        "descricao TEXT,"
        "data DATETIME)";
    await db.execute(sql);
  }

  inicialixaDB() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "db_anotacoes.db");
    var db =
        await openDatabase(localBancoDados, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<int> SalvarLista(Lista lista) async {
    var bancoDados = await db;
    int id = await bancoDados.insert(nomeTebelaPrincipal, lista.toMap());
    return id;
  }

  Future<int> SalvarTarefas(Tarefa tarefa) async {
    var bancodados = await db;
    int id = await bancodados.insert(nomeTabelasecundaria, tarefa.toMap());
    return id;
  }

  RecuperaListas() async {
    var bancoDados = await db;
    String sql = "SELECT * FROM $nomeTebelaPrincipal ORDER BY data DESC";
    List anotacao = await bancoDados.rawQuery(sql);
    return anotacao;
  }

  RecuperaTarefas(int id) async {
    var bancoDados = await db;
    String sql =
        "SELECT * FROM $nomeTabelasecundaria WHERE id_lista = $id ORDER BY data DESC";
    List tarefa = await bancoDados.rawQuery(sql);
    return tarefa;
  }

  Future<int> AtualizandoLista(Lista lista) async {
    var bancodados = await db;
    return await bancodados.update(nomeTebelaPrincipal, lista.toMap(),
        where: "id = ?", whereArgs: [lista.id]);
  }

  Future<int> AtualizarTarefa(Tarefa tarefa) async {
    var bancoDados = await db;
    return await bancoDados.update(nomeTabelasecundaria, tarefa.toMap(),
        where: "id = ?", whereArgs: [tarefa.id]);
  }

  Future<int> ExcluindoLista(int id) async {
    var bancoDados = await db;
    return await bancoDados
        .delete(nomeTebelaPrincipal, where: "id = ?", whereArgs: [id]);
  }

  Future<int> ExcluindoTarefas(int id) async {
    var bancoDados = await db;
    return await bancoDados
        .delete(nomeTabelasecundaria, where: "id = ?", whereArgs: [id]);
  }
}
