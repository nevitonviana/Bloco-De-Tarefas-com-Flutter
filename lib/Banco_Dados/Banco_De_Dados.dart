import 'package:bloco_de_anotacao/Banco_Dados/Listas.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BancoDados {
  static final String nomeTebelaPrincipal = "lista";
  static final String nomeTabelasecundaria = "anotacao";
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

  Future<int> SalvarAnotacao(Lista anotacao) async {
    var bancoDados = await db;
    int id = await bancoDados.insert(nomeTebelaPrincipal, anotacao.toMap());
    return id;
  }

  recuoeraAnotacao() async {
    var bancoDados = await db;
    String sql = "SELECT * FROM $nomeTebelaPrincipal ORDER BY data DESC";
    List anotacao = await bancoDados.rawQuery(sql);
    return anotacao;
  }

  Future<int> atualizarAnotcao(Lista anotacao) async {
    var bancodados = await db;
    return await bancodados.update(nomeTebelaPrincipal, anotacao.toMap(),
        where: "id = ?", whereArgs: [anotacao.id]);
  }

  Future<int> excluirDados(int id) async {
    var bancoDados = await db;
    return await bancoDados.delete(
        nomeTebelaPrincipal,
        where: "id = ?",
        whereArgs: [id]
    );
  }
}
