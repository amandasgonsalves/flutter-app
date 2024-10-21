import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_page.dart'; // Certifique-se de que o caminho está correto

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NBA Finals',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(), // Inicializa a HomePage
    );
  }
}
