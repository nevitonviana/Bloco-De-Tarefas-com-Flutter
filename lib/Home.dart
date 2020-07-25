import 'package:bloco_de_anotacao/Banco_Dados/Banco_De_Dados.dart';
import 'package:bloco_de_anotacao/Banco_Dados/Listas.dart';
import 'package:bloco_de_anotacao/Tela_De_Tarefas.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Home> {
  //declaração de variaves
  List<Lista> _lista = List();
  TextEditingController _controllerLista = TextEditingController();
  TextEditingController _controllerTarefas = TextEditingController();

  var _db = BancoDados();

  Exibir_e_Atualizar_Lista({Lista lista}) {
    String textSalvar_Atualizar;
    if (lista == null) {
      _controllerLista.clear();
      _controllerLista.clear();
      textSalvar_Atualizar = "Salvar";
    } else {
      _controllerLista.text = lista.titulo;
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
                  controller: _controllerLista,
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: "Lista",
                      hintText: "Digite una Lista De tarefas"),
                ),
                if (lista == null)
                  TextField(
                    controller: _controllerTarefas,
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
                  if (_controllerLista.text != "") {
                    Salvar_E_Atualizar_DadosLista(list: lista);
                    Navigator.pop(context);
                  }
                },
              )
            ],
          );
        });
  }

  Salvar_E_Atualizar_DadosLista({Lista list}) async {
    String titulo = _controllerLista.text;
    String tarefa = _controllerTarefas.text;
    if (list == null) {
      Lista lista = Lista(titulo, DateTime.now().toString());
      int _resultado = await _db.SalvarLista(lista);
    } else {
      list.titulo = titulo;
      list.data = DateTime.now().toString();
      int _resultado = await _db.AtualizandoLista(list);
    }
    _controllerTarefas.clear();
    _controllerLista.clear();
    _recupera();
  }

  _recupera() async {
    List listaRecuperada = await _db.RecuperaListas();
    List<Lista> listaTemporaria = List<Lista>();
    for (var item in listaRecuperada) {
      Lista lista = Lista.fromMap(item);
      listaTemporaria.add(lista);
    }
    setState(() {
      _lista = listaTemporaria;
    });
    listaTemporaria = null;
  }

  _RemoverLista(int id) async {
    await _db.ExcluindoLista(id);
    _recupera();
  }

  @override
  void initState() {
    super.initState();
    _recupera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bloco De Anotação",
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
                    final lista = _lista[index];
                    return Card(
                      child: ListTile(
                        title: Text(lista.titulo),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                            Tela_de_tarefas(lista.id, lista.titulo))),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Exibir_e_Atualizar_Lista(lista: lista);
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
                                                  lista.titulo),
                                          actions: <Widget>[
                                            FlatButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text("Cancelar")),
                                            FlatButton(
                                                onPressed: () {
                                                  _RemoverLista(lista.id);
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
