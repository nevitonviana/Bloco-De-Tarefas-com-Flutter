class Tarefas {
  int? id;
  int? idBloco;
  String? tarefa;
  String tarefaRealizada = "false";
  String? data;

  Tarefas({
    this.id,
    this.idBloco,
    this.tarefa,
    this.tarefaRealizada = "false",
    this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "idBloco": idBloco,
      "tarefa": tarefa,
      "tarefaRealizada": tarefaRealizada,
      "data": data,
    };
  }

  factory Tarefas.fromMap(Map<String, dynamic> map) {
    return Tarefas(
      id: map["id"],
      idBloco: map["idBloco"],
      tarefa: map["tarefa"],
      tarefaRealizada: map["tarefaRealizada"],
      data: map["data"]
    );
  }
}
