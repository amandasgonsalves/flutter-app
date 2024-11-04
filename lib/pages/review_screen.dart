import 'package:flutter/material.dart';

class ReviewScreen extends StatefulWidget {
  final List<Map<String, String>> cards;

  ReviewScreen({required this.cards});

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int _currentIndex = 0;
  bool _showAnswer = false;
  List<Map<String, String>> _reviewQueue = [];

  @override
  void initState() {
    super.initState();
    _reviewQueue = List.from(widget.cards); // Inicializa a fila de revisão
  }

  void _nextCard() {
    setState(() {
      _showAnswer = false;
      if (_reviewQueue.isNotEmpty) {
        _currentIndex = (_currentIndex + 1) % _reviewQueue.length;
      } else {
        _currentIndex = 0;
      }
    });
  }

  void _markDifficulty(String difficulty) {
    final currentCard = _reviewQueue[_currentIndex];

    setState(() {
      switch (difficulty) {
        case 'difícil':
          // Adiciona o card duas vezes na fila para aumentar a frequência
          _reviewQueue.add(currentCard);
          _reviewQueue.add(currentCard);
          break;
        case 'bom':
          // Adiciona o card uma vez na fila para manter uma frequência moderada
          _reviewQueue.add(currentCard);
          break;
        case 'fácil':
          // Remove o card da fila para evitar repetições
          _reviewQueue.removeAt(_currentIndex);
          _currentIndex = _currentIndex % _reviewQueue.length;
          break;
      }
      _nextCard(); // Avança para o próximo card após a marcação
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_reviewQueue.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Revisão')),
        body: Center(child: Text('Nenhum card disponível para revisão.')),
      );
    }

    final currentCard = _reviewQueue[_currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text('Revisão de Cards')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pergunta:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              currentCard['question'] ?? '',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            if (_showAnswer)
              Column(
                children: [
                  Text(
                    'Resposta:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    currentCard['answer'] ?? '',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showAnswer = !_showAnswer;
                });
              },
              child:
                  Text(_showAnswer ? 'Ocultar Resposta' : 'Mostrar Resposta'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => _markDifficulty('difícil'),
                  child: Text('Difícil'),
                ),
                ElevatedButton(
                  onPressed: () => _markDifficulty('bom'),
                  child: Text('Bom'),
                ),
                ElevatedButton(
                  onPressed: () => _markDifficulty('fácil'),
                  child: Text('Fácil'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
