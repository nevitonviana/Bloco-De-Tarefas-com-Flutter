import 'package:bloco_de_tarefas/shared/model/blocos.dart';
import 'package:mobx/mobx.dart';

import '/shared/database/Database.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  BancoDeDados _db = BancoDeDados();

  //textField title
  @observable
  String title = "";

  @action
  void setTitle(String value) => title = value;

  @computed
  bool get titleValid => title.length >= 0;

  String? get titleError {
    if (titleValid && title.isEmpty)
      return "Este Campo e obrigatorio";
    else
      return null;
  }

//check
  @observable
  bool checkBox = false;

  @action
  void setCheckBox(bool value) => checkBox = value;

  //button
  @computed
  dynamic get formValid => titleValid ? _send : null;

  @action
  Future<void> _send() async {
    Blocos _blocos = Blocos(
      data: DateTime.now().toString(),
      nomeDoBloco: title,
    );
    await _db.createBloco(_blocos);
  }
}
