class Blocos {
  int? id;
  String? nomeDoBloco;
  String listaRealizada = "false";
  String? data;

  Blocos({
    this.id,
    this.nomeDoBloco,
    this.listaRealizada = "false",
    this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nomeDoBloco": nomeDoBloco,
      "listaRealizada": listaRealizada,
      "data": data,
    };
  }

  factory Blocos.fromMap(Map<String, dynamic> map) {
    return Blocos(
      id: map["id"],
      nomeDoBloco: map["nomeDoBloco"],
      listaRealizada: map["listaRealizada"],
      data: map["data"],
    );
  }
}
