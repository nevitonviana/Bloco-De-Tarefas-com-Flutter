import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '/pages/tarefa/components/dialog.dart';
import '/pages/tarefa/controller/tarefa_controller.dart';
import '/shared/model/blocos.dart';
import '/shared/model/tarefas.dart';
import '/shared/util/formataData.dart';

class TarefaPage extends StatefulWidget {
  final Blocos blocos;

  const TarefaPage({Key? key, required this.blocos}) : super(key: key);

  @override
  _TarefaPageState createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  //variaveis
  final TarefaController _tarefaController = TarefaController();

  _selectedValue(var value, Tarefas tarefas) async {
    if (value == "1") {
      await OpenDialog().delete(
        tarefas: tarefas,
        context: context,
        tarefaController: _tarefaController,
      );
    } else {
      OpenDialog().textField(
        context: context,
        tarefaController: _tarefaController,
        tarefas: tarefas,
      );
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
            onPressed: () => OpenDialog().textField(
              context: context,
              tarefaController: _tarefaController,
            ),
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
