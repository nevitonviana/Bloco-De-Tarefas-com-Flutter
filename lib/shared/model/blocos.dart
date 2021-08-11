class Blocos {
  String? id;
  String? nomeDoBloco;
  String? listaRealizada;

  Blocos({
    this.id,
    this.nomeDoBloco,
    this.listaRealizada,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nomeDoBloco": nomeDoBloco,
      "listaRealizada": listaRealizada,
    };
  }

  Blocos.fromMap(Map map) {
    this.id = map["id"];
    this.nomeDoBloco= map["nomeDoBloco"];
    this.listaRealizada = map["listaRealizada"];
  }
}
