import 'package:flutter/material.dart';
import 'pages/Home_Page.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blueGrey.shade200,
        splashColor: Colors.amber,
        accentColor: Colors.blueGrey.shade300,
        cardColor: Colors.grey.shade400,
        cardTheme: CardTheme(elevation: 10),
        popupMenuTheme: PopupMenuThemeData(
            color: Colors.blueGrey.shade300,
            elevation: 6,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))),
        checkboxTheme: CheckboxThemeData(
            checkColor: MaterialStateProperty.all(Colors.black),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fillColor: MaterialStateProperty.all(Colors.blue)),
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}
