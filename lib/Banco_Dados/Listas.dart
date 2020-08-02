class Lista {
  int id;
  String titulo;
  String lista_realizada;
  String data;

  Lista(this.titulo, this.lista_realizada, this.data);

  Lista.fromMap(Map map) {
    this.id = map["id"];
    this.titulo = map["titulo"];
    this.lista_realizada = map["lista_realizada"];
    this.data = map["data"];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "titulo": this.titulo,
      "lista_realizada": this.lista_realizada,
      "data": this.data,
    };
    if (this.id != null) {
      map["id"] = this.id;
    }
    return map;
  }
}
