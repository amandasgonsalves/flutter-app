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
        appBar: AppBar(
          title: Text('Revisão',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.blueAccent, // Cor do fundo da AppBar
        ),
        body: Center(
          child: Container(
            color: Colors.lightBlue[50], // Cor de fundo do corpo
            padding: EdgeInsets.all(20), // Espaçamento interno
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons
                      .sentiment_satisfied, // Ícone feliz para indicar que a revisão foi concluída
                  size: 80,
                  color: Colors.green, // Cor do ícone
                ),
                SizedBox(height: 20),
                Text(
                  'Parabéns! Você revisou todos os cards deste baralho!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Cor do texto
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    final currentCard = _reviewQueue[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Revisão de Cards', style: TextStyle(fontSize: 24)),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => _markDifficulty('difícil'),
                  child: Text('Difícil'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _markDifficulty('bom'),
                  child: Text('Bom'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _markDifficulty('fácil'),
                  child: Text('Fácil'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
