import 'package:bloco_de_anotacao/Banco_Dados/Tarefa.dart';
import 'package:flutter/material.dart';
import 'Banco_Dados/Banco_De_Dados.dart';
import 'Banco_Dados/Banco_De_dados2.dart';

class Tela_de_tarefas extends StatefulWidget {
  int id;
  String titulo;

  Tela_de_tarefas(this.id, this.titulo);

  @override
  _State createState() => _State();
}

class _State extends State<Tela_de_tarefas> {
  //declaração de variaves
  List<Tarefa> _lista = List();
  TextEditingController _controllerTarefas = TextEditingController();

  var _db = BancoDados2();

  Exibir_e_Atualizar_Lista({Tarefa tarefa}) {
    String textSalvar_Atualizar;
    if (tarefa == null) {
      _controllerTarefas.clear();
      textSalvar_Atualizar = "Salvar";
    } else {
      _controllerTarefas.text = tarefa.tarefa;
      textSalvar_Atualizar = "Atualizar";
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("$textSalvar_Atualizar Anotações"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _controllerTarefas,
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: "Tarefa",
                      hintText: "Digite uma tarefa da Lista"),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancelar"),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                child: Text(textSalvar_Atualizar),
                onPressed: () {
                  if (_controllerTarefas.text != "") {
                    print("iddd" + "foi");
                    Salvar_E_Atualizar_DadosTarefas(lista: tarefa);
                    Navigator.pop(context);
                  }
                },
              )
            ],
          );
        });
  }

  Salvar_E_Atualizar_DadosTarefas({Tarefa lista}) async {
    String tarefa = _controllerTarefas.text;
    if (lista == null) {
      Tarefa lista = Tarefa(widget.id,tarefa, DateTime.now().toString());
      int _resultado = await _db.SalvarTarefas(lista);
    } else {
      lista.tarefa = tarefa;
      lista.data = DateTime.now().toString();
      int _resultado = await _db.AtualizarTarefa(lista);
    }
    _controllerTarefas.clear();
    _recuperaTarefa();
  }

  _recuperaTarefa() async {
    List listaRecuperada = await _db.RecuperaTarefas(widget.id);
    List<Tarefa> listaTemporaria = List<Tarefa>();
    for (var item in listaRecuperada) {
      Tarefa tarefa = Tarefa.froMap(item);
      listaTemporaria.add(tarefa);
    }
    setState(() {
      _lista = listaTemporaria;
    });
    listaTemporaria = null;
  }

  _RemoverLista(int id) async {
    await _db.ExcluindoTarefas(id);
    _recuperaTarefa();
  }

  @override
  void initState() {
    super.initState();
    _recuperaTarefa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.titulo,
          style: TextStyle(
              foreground: Paint()..color = Color(0xffa3b4ba),
              decorationStyle: TextDecorationStyle.double),
        ),
        backgroundColor: Color(0xffe2e3c4),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
                  itemCount: _lista.length,
                  itemBuilder: (context, index) {
                    final tarefa = _lista[index];
                    return Card(
                      child: ListTile(
                        title: Text(tarefa.tarefa),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Exibir_e_Atualizar_Lista(tarefa: tarefa);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: Icon(
                                  Icons.mode_edit,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                              "Tem certeza que deseja excluir?  " +
                                                  tarefa.tarefa),
                                          actions: <Widget>[
                                            FlatButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text("Cancelar")),
                                            FlatButton(
                                                onPressed: () {
                                                  _RemoverLista(tarefa.id);
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Excluir"))
                                          ],
                                        );
                                      });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 0),
                                  child: Icon(
                                    Icons.remove_circle_outline,
                                    color: Colors.red,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.purple,
        child: Icon(Icons.add_box),
        onPressed: () {
          Exibir_e_Atualizar_Lista();
        },
      ),
    );
  }
}
