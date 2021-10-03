import 'package:mobx/mobx.dart';

import '/shared/database/Database.dart';
import '/shared/model/tarefas.dart';

part 'tarefa_controller.g.dart';

class TarefaController = _TarefaControllerBase with _$TarefaController;

abstract class _TarefaControllerBase with Store {
  BancoDeDados _db = BancoDeDados();

  _TarefaControllerBase() {
    reaction((_) => blocoId != null, (_) {
      _getListTarefas();
    });
  }

  Future<void> _getListTarefas() async {
    var dados = await _db.readTarefa(blocoId!);
    List<Tarefas> _temporaryList = [];
    listTarefa.clear();
    for (dynamic item in dados) {
      _temporaryList.add(Tarefas.fromMap(item));
    }
    listTarefa.addAll(_temporaryList);
    _temporaryList.clear();
  }

  //lista de tarefa
  ObservableList<Tarefas> listTarefa = ObservableList();

  @observable
  int? blocoId;

  @action
  void setBlocoId(int value) => blocoId = value;

  //title
  @observable
  String title = "";

  @action
  void setTitle(String value) => title = value;

  @computed
  bool get titleValid => title.length < 0;

  String? get titleError {
    if (titleValid && title.isEmpty) {
      return "Campo Obrigatorio";
    } else {
      return null;
    }
  }

//check
  @observable
  bool checkbox = false;

  @action
  void setCheckbox(bool value) => checkbox = value;

  ///save checkBox in db
  Future<void> saveCheckBox({required Tarefas tarefa}) async {
    tarefa.tarefaRealizada = checkbox.toString();
    await _db.updateTarefa(tarefa);
    await _getListTarefas();
  }

  void send({Tarefas? tarefa}) {
    if (tarefa == null) {
      _save();
    } else {
      _update(tarefa: tarefa);
    }
  }

  ///save tarefa in db
  Future<void> _save() async {
    //TODO id bloco
    Tarefas tarefa = Tarefas(
      data: DateTime.now().toString(),
      idBloco: blocoId,
      tarefa: title,
    );
    await _db.createTarefa(tarefa);
    listTarefa.insert(0, tarefa);
  }

  ///update tarefa
  Future<void> _update({required Tarefas tarefa}) async {
    tarefa.tarefa = title;
    await _db.updateTarefa(tarefa);
    _getListTarefas();
  }

  ///delete tarefa
  Future<void> remove({required Tarefas tarefa}) async {
    await _db.deleteTarefa(tarefa.id!);
    listTarefa.removeWhere((element) => element.id == tarefa.id);
  }
}
