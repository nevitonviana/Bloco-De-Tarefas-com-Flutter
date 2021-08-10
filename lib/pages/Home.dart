import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  child: Card(
                    elevation: 6,
                    color: Colors.grey.shade200,
                    child: ListTile(
                      title: Text("teste"),
                    ),
                  ),
                );
              },
            ),
          )
        );
      },
    );
  }
}
