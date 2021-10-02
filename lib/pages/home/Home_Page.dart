import 'package:animated_card/animated_card.dart';
import 'package:bloco_de_tarefas/pages/Tarefa_Page.dart';
import 'package:bloco_de_tarefas/pages/home/comtroller/home_controller.dart';
import 'package:bloco_de_tarefas/shared/model/blocos.dart';
import 'package:bloco_de_tarefas/shared/util/formataData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //variaveis
  Blocos _blocos = Blocos();
  final _formKey = GlobalKey<FormState>();

  final HomeController _homeController = HomeController();

  _abrirDialogDeTextField({Blocos? blocos}) async {
    final nameTag = blocos == null ? "Adicionar" : "Atualizar";
    _blocos = blocos != null ? blocos : _blocos;
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
            child: Form(
              key: _formKey,
              child: Observer(builder: (_) {
                return TextFormField(
                  onChanged: _homeController.setTitle,
                  initialValue: blocos != null ? blocos.nomeDoBloco! : "",
                  autofocus: true,
                  decoration: InputDecoration(
                    errorText: _homeController.titleError,
                    labelText: "bloco de Tarefa",
                  ),
                );
              }),
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
                _homeController.send(bloco: blocos);
                Navigator.of(context).pop();
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

  _dialogDelete(Blocos blocos) async {
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
                          text: blocos.nomeDoBloco,
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
                          _homeController.delete(blocos);
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

  _selectedValue(var value, Blocos blocos) async {
    if (value == "1") {
      await _dialogDelete(blocos);
    } else {
      _abrirDialogDeTextField(blocos: blocos);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Bloco De Tarefas"),
            centerTitle: true,
          ),
          body: Container(
            child: Observer(builder: (context) {
              return ListView.builder(
                itemCount: _homeController.listBlocos.length,
                itemBuilder: (context, index) {
                  final _bloco = _homeController.listBlocos[index];
                  return Container(
                    padding: EdgeInsets.only(top: 10, right: 10, left: 10),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TarefaPage(
                            blocos: _bloco,
                          ),
                        ),
                      ),
                      child: AnimatedCard(
                        child: Card(
                          shadowColor: _bloco.listaRealizada == "false"
                              ? Colors.red
                              : Colors.blue,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Checkbox(
                                    value:
                                        _bloco.listaRealizada.toLowerCase() ==
                                            "true",
                                    onChanged: (value) {
                                      _homeController.setCheckBox(value!);
                                      _homeController.saveCheckBox(
                                          bloco: _bloco);
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    child: Text(
                                      _bloco.nomeDoBloco ?? "null",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        decoration: TextDecoration.combine(
                                          [
                                            _bloco.listaRealizada == "true"
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
                                                  selectedValue, _bloco),
                                          itemBuilder: (_) => [
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
                                        Data().data(_bloco.data.toString()),
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
                    ),
                  );
                },
              );
            }),
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
