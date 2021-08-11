class Tarefas {
  String? id;
  String? tarefa;
  String? tarefaRealizada;

  Tarefas({
    this.id,
    this.tarefa,
    this.tarefaRealizada,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "tarefa": tarefa,
      "tarefaRealizada": tarefaRealizada,
    };
  }

  Tarefas.fromMap(Map map) {
    this.id = map["id"];
    this.tarefa = map["tarefa"];
    this.tarefaRealizada = map["tarefaRealizada"];
  }
}
