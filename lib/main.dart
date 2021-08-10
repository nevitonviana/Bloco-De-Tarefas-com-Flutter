import 'package:bloco_de_tarefas/pages/Home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(primaryColor: Colors.blueGrey.shade200, splashColor: Colors.amber,accentColor: Colors.blueGrey.shade200,),
      home: HomePage(),
    ),
  );
}
