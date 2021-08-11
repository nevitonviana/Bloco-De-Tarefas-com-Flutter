import 'package:flutter/material.dart';
import 'pages/Home_Page.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blueGrey.shade200,
        splashColor: Colors.amber,
        accentColor: Colors.blueGrey.shade200,
      ),
      home: HomePage(),
    ),
  );
}
