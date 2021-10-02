import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '/shared/model/blocos.dart';
import '../controller/home_controller.dart';

class OpenDialog {
  TextField(
      {Blocos? blocos,
      required BuildContext context,
      required HomeController homeController}) async {
    final nameTag = blocos == null ? "Adicionar" : "Atualizar";
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
            child: Observer(builder: (_) {
              return TextFormField(
                onChanged: homeController.setTitle,
                initialValue: blocos != null ? blocos.nomeDoBloco! : "",
                autofocus: true,
                decoration: InputDecoration(
                  errorText: homeController.titleError,
                  labelText: "bloco de Tarefa",
                ),
              );
            }),
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
                homeController.send(bloco: blocos);
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
}
