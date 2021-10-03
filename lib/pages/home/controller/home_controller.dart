import 'package:mobx/mobx.dart';

import '/shared/database/Database.dart';
import '/shared/model/blocos.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  BancoDeDados _db = BancoDeDados();

  _HomeControllerBase() {
    autorun((_) async {
      await _getListBlocos();
    });
  }

  Future<void> _getListBlocos() async {
    List<Blocos> _temporaryList = [];
    final dados = await _db.readBloco();

    listBlocos.clear();
    for (dynamic item in dados) {
      _temporaryList.add(Blocos.fromMap(item));
    }
    listBlocos.addAll(_temporaryList);
    _temporaryList.clear();
  }

  //ListBloco
  ObservableList<Blocos> listBlocos = ObservableList<Blocos>();

  //textField title
  @observable
  String title = "";

  @action
  void setTitle(String value) => title = value;

  @computed
  bool get titleValid => title.length > 0;

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

  Future<void> saveCheckBox({required Blocos bloco}) async {
    bloco.listaRealizada = checkBox.toString();
    await _db.updateBloco(bloco);
    await _getListBlocos();
  }

  @action
  Future<void> send({Blocos? bloco}) async {
    if (bloco == null) {
      _save();
    } else {
      _update(bloco);
    }
  }

  /// save bloco
  Future<void> _save() async {
    Blocos _blocos = Blocos(
      data: DateTime.now().toString(),
      nomeDoBloco: title,
    );
    await _db.createBloco(_blocos);
    _getListBlocos();
  }

  /// Delete bloco
  Future<void> delete(Blocos blocos) async {
    listBlocos.removeWhere((element) => element.id == blocos.id);
    await _db.deleteBloco(blocos.id!);
  }

  /// update bloco
  Future<void> _update(Blocos blocos) async {
    blocos.nomeDoBloco = title;
    await _db.updateBloco(blocos);
    await _getListBlocos();
  }
}
