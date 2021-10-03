import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '/pages/home/components/open_dialog.dart';
import '/pages/tarefa/Tarefa_Page.dart';
import '/shared/model/blocos.dart';
import '/shared/util/formataData.dart';
import 'controller/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //variaveis
  final HomeController _homeController = HomeController();

  _selectedValue(
      {var value,
      required Blocos blocos,
      required BuildContext context}) async {
    if (value == "1") {
      await OpenDialog().delete(
        context: context,
        blocos: blocos,
        homeController: _homeController,
      );
    } else {
      OpenDialog().textField(
        blocos: blocos,
        context: context,
        homeController: _homeController,
      );
    }
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
            child: Observer(
              builder: (_) {
                return ListView.builder(
                  itemCount: _homeController.listBlocos.length,
                  itemBuilder: (context, index) {
                    final _bloco = _homeController.listBlocos[index];
                    return Container(
                      padding: EdgeInsets.only(top: 10, right: 10, left: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TarefaPage(
                                blocos: _bloco,
                              ),
                            ),
                          );
                        },
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          PopupMenuButton(
                                              onSelected: (selectedValue) =>
                                                  _selectedValue(
                                                    value: selectedValue,
                                                    blocos: _bloco,
                                                    context: context,
                                                  ),
                                              itemBuilder: (_) => [
                                                    PopupMenuItem(
                                                        child: ListTile(
                                                          leading: Icon(
                                                            Icons
                                                                .delete_forever,
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
                                      ),
                                    ),
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
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => OpenDialog()
                .textField(context: context, homeController: _homeController),
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
