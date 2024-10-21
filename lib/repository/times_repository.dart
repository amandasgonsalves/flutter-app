import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/time.dart';
import 'package:flutter_application_1/models/titulo.dart';

class TimesRepository {
  // Lista privada de times
  final List<Time> _times = [];

  // Getter para acessar a lista de times (retorna uma lista não-nula)
  List<Time> get times => _times;

  // Método para adicionar informações a um time existente
  void addInfos(Time time, Titulo titulo) {
    time.titulo.add(titulo);
  }

  // Construtor que inicializa a lista de times
  TimesRepository() {
    _times.addAll([
      Time(
        brasao:
            'https://upload.wikimedia.org/wikipedia/en/a/a0/Indiana_Pacers_logo.svg',
        nome: 'Indiana Pacers',
        pontos: 12,
        cor: Color(0xFF0000FF), // Azul
        titulo: [Titulo(estado: 'Indiana', conference: 'Leste')],
      ),
      Time(
        brasao:
            'https://upload.wikimedia.org/wikipedia/en/1/1f/Milwaukee_Bucks_logo.svg',
        nome: 'Milwaukee Bucks',
        pontos: 17,
        cor: Color(0xFF006400), // Verde escuro
        titulo: [Titulo(estado: 'Milwaukee', conference: 'Leste')],
      ),
    ]);
  }
}
