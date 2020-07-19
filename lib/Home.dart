import 'package:bloco_de_anotacao/Banco_Dados/Banco_De_Dados.dart';
import 'package:bloco_de_anotacao/Banco_Dados/Listas.dart';

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
  bool a = true;
  var _db = BancoDados();





  Salvar_E_Atualizar_DadosLista({Lista list}) async {
    String titulo = _controllerLista.text;
    if (list == null) {
      Lista lista = Lista(titulo, DateTime.now().toString());
      int _resultado = await _db.SalvarAnotacao(lista);
    } else {
      list.titulo = titulo;
      list.data = DateTime.now().toString();
      int _resultado = await _db.atualizarAnotcao(list);
    }
    _recupera();
  }

  _recupera()async{
    List listaRecuperada = await _db.recuoeraAnotacao();
    List<Lista> listaTemporaria = List<Lista>();
    for (var item in listaRecuperada) {
      Lista lista = Lista.fromMap(item);
      listaTemporaria.add(lista);
    }


    setState(() {
      print("aaaaaa  "+listaTemporaria.length.toString());
      _lista = listaTemporaria;
    });

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
                    final anotacao = _lista[index];
                    return Card(
                      child: ListTile(
                        title: Text(anotacao.titulo),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                _recupera();
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
                                                  anotacao.titulo),
                                          actions: <Widget>[
                                            FlatButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text("Cancelar")),
                                            FlatButton(
                                                onPressed: () {

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
      //    _Exibir_e_Atualizar_Lista();
        },
      ),
    );
  }
}
