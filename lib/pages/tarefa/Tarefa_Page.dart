import 'package:animated_card/animated_card.dart';
import 'package:bloco_de_tarefas/pages/tarefa/controller/tarefa_controller.dart';
import 'package:bloco_de_tarefas/shared/model/blocos.dart';
import 'package:bloco_de_tarefas/shared/model/tarefas.dart';
import 'package:bloco_de_tarefas/shared/util/formataData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class TarefaPage extends StatefulWidget {
  final Blocos blocos;

  const TarefaPage({Key? key, required this.blocos}) : super(key: key);

  @override
  _TarefaPageState createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  //variaveis
  final TarefaController _tarefaController = TarefaController();

  _abrirDialogDeTextField({Tarefas? tarefas}) async {
    final nameTag = tarefas == null ? "Adicionar" : "Atualizar";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 6,
          title: Text(
            nameTag,
            textAlign: TextAlign.center,
          ),
          content: Container(
            child: Observer(
              builder: (_) {
                return TextFormField(
                  onChanged: _tarefaController.setTitle,
                  initialValue: tarefas != null ? tarefas.tarefa! : "",
                  decoration: InputDecoration(
                    errorText: _tarefaController.titleError,
                    labelText: "bloco de Tarefa",
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancelar",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            TextButton(
              onPressed: () {
                _tarefaController.send(tarefa: tarefas);
                Navigator.pop(context);
              },
              child: Text(
                nameTag,
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        );
      },
    );
  }

  _dialogDelete(Tarefas tarefas) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final double horizontal = 130;
        return Dialog(
          elevation: 6,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: horizontal, vertical: 18),
                  color: Colors.red,
                  child: Text(
                    "Excluir",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 60),
                  child: Text.rich(
                    TextSpan(
                      text: "Você quer Excluir \n\n",
                      style: TextStyle(fontSize: 15),
                      children: [
                        TextSpan(
                          text: tarefas.tarefa,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        onPressed: () => Navigator.pop(context),
                        color: Colors.blueAccent,
                        child: Text(
                          "Cancelar",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 15),
                      MaterialButton(
                        color: Colors.red,
                        onPressed: () async {
                          _tarefaController.remove(tarefa: tarefas);
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Excluir",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _selectedValue(var value, Tarefas tarefas) async {
    if (value == "1") {
      await _dialogDelete(tarefas);
    } else {
      _abrirDialogDeTextField(tarefas: tarefas);
    }
  }

  @override
  void initState() {
    _tarefaController.setBlocoId(widget.blocos.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.blocos.nomeDoBloco!),
            centerTitle: true,
          ),
          body: Container(
            child: Observer(
              builder: (_) {
                return ListView.builder(
                  itemCount: _tarefaController.listTarefa.length,
                  itemBuilder: (context, index) {
                    final _tarefa = _tarefaController.listTarefa[index];
                    return Container(
                      padding: EdgeInsets.only(top: 10, right: 10, left: 10),
                      child: AnimatedCard(
                        direction: AnimatedCardDirection.left,
                        child: Card(
                          elevation: 6,
                          shadowColor: _tarefa.tarefaRealizada == "false"
                              ? Colors.red
                              : Colors.blue,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Checkbox(
                                    value:
                                        _tarefa.tarefaRealizada.toLowerCase() ==
                                            "true",
                                    onChanged: (value) {
                                      _tarefaController.setCheckbox(value!);
                                      _tarefaController.saveCheckBox(
                                          tarefa: _tarefa);
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    child: Text(
                                      _tarefa.tarefa!,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        decoration: TextDecoration.combine(
                                          [
                                            _tarefa.tarefaRealizada == "true"
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                      child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      PopupMenuButton(
                                          onSelected: (selectedValue) =>
                                              _selectedValue(
                                                  selectedValue, _tarefa),
                                          itemBuilder: (BuildContext ctx) => [
                                                PopupMenuItem(
                                                    child: ListTile(
                                                      leading: Icon(
                                                        Icons.delete_forever,
                                                        color: Colors.red,
                                                      ),
                                                      title: Text("Deleta"),
                                                    ),
                                                    value: '1'),
                                                PopupMenuItem(
                                                    child: ListTile(
                                                      leading: Icon(
                                                        Icons.edit,
                                                        color: Colors.blue,
                                                      ),
                                                      title: Text("Edita"),
                                                    ),
                                                    value: '2'),
                                              ]),
                                      Text(
                                        Data().data(_tarefa.data.toString()),
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ],
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _abrirDialogDeTextField(),
            elevation: 6,
            child: Icon(
              Icons.add_circle_outline_outlined,
              size: 30,
            ),
            focusElevation: 3,
          ),
        );
      },
    );
  }
}
