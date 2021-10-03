import 'package:flutter/material.dart';

import 'pages/home/Home_Page.dart';

void main() async {
  runApp(
    MaterialApp(
      theme: ThemeData(
        splashColor: Colors.amber,
        colorScheme: ColorScheme(
          primary: Colors.blueGrey.shade200,
          primaryVariant: Colors.red,
          secondary: Colors.blueGrey.shade300,
          secondaryVariant: Colors.red,
          surface: Colors.blue,
          background: Colors.blue,
          error: Colors.red,
          onPrimary: Colors.black,
          onSecondary: Colors.black,
          onSurface: Colors.blue,
          onBackground: Colors.blue,
          onError: Colors.red,
          brightness: Brightness.light,
        ),
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
      debugShowCheckedModeBanner: true,
      home: HomePage(),
    ),
  );
}

