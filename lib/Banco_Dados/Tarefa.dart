class Tarefa {
  int id;
  int id_lista;
  String tarefa;
  String data;

  Tarefa(this.id_lista, this.tarefa, this.data);

  Tarefa.froMap(Map map) {
    this.id = map["id"];
    this.id_lista = map["id_lista"];
    this.tarefa = map["tarefa"];
    this.data = map["data"];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "id_lista": this.id_lista,
      "tarefa": this.tarefa,
      "data": this.data,
    };
    if (this.id != null) {
      map["id"] = this.id;
    }
    return map;
  }
}
