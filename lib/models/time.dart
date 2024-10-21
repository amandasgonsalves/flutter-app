import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/titulo.dart';

class Time {
  String nome;
  String brasao;
  int pontos;
  Color cor;
  List<Titulo> titulo = [];

  Time({
    required this.brasao,
    required this.nome,
    required this.pontos,
    required this.cor,
    required this.titulo,
  });
}
