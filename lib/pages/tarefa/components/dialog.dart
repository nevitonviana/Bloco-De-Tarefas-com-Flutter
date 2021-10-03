import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '/pages/tarefa/controller/tarefa_controller.dart';
import '/shared/model/tarefas.dart';

class OpenDialog {
  delete({
    required Tarefas tarefas,
    required BuildContext context,
    required TarefaController tarefaController,
  }) async {
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
                          tarefaController.remove(tarefa: tarefas);
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

  textField(
      {Tarefas? tarefas,
      required BuildContext context,
      required TarefaController tarefaController}) async {
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
                  onChanged: tarefaController.setTitle,
                  initialValue: tarefas != null ? tarefas.tarefa! : "",
                  decoration: InputDecoration(
                    errorText: tarefaController.titleError,
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
                tarefaController.send(tarefa: tarefas);
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
}
