import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewScreen extends StatefulWidget {
  final List<Map<String, String>> cards;

  const ReviewScreen({super.key, required this.cards});

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int _currentIndex = 0;
  bool _showAnswer = false;
  List<Map<String, String>> _reviewQueue = [];
  int _dailyLimit = 0;
  int _cardsReviewed =
      0; // Variável para controlar quantos cards foram revisados

  @override
  void initState() {
    super.initState();
    _reviewQueue = List.from(widget.cards); // Inicializa a fila de revisão
    _loadDailyLimit();
  }

  // Função para carregar o limite de cartões salvos
  Future<void> _loadDailyLimit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _dailyLimit =
          prefs.getInt('dailyLimit') ?? 0; // Recupera o limite de cartões
    });
  }

  // Função para obter o limite diário
  Future<int> _getDailyLimit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('dailyLimit') ?? 0; // Recuperar o limite de cartões
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

  void _markDifficulty(String difficulty) async {
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
      _cardsReviewed++; // Incrementa o número de cartões revisados
      _nextCard(); // Avança para o próximo card após a marcação
    });
  }

  // Função para verificar o limite diário antes de continuar revisando
  Future<void> _checkDailyLimit() async {
    int dailyLimit = await _getDailyLimit();
    if (_cardsReviewed >= dailyLimit && dailyLimit > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Você atingiu o limite diário de revisão de cartões.'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      // Se não atingiu o limite, permite avançar
      _markDifficulty('bom'); // Exemplo de chamada de marcação de dificuldade
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_reviewQueue.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Revisão',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.blueAccent, // Cor do fundo da AppBar
        ),
        body: Center(
          child: Container(
            color: Colors.lightBlue[50], // Cor de fundo do corpo
            padding: const EdgeInsets.all(20), // Espaçamento interno
            child: const Column(
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
        title: const Text('Revisão de Cards', style: TextStyle(fontSize: 24)),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
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
            const Text(
              'Pergunta:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              currentCard['question'] ?? '',
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            if (_showAnswer)
              Column(
                children: [
                  const Text(
                    'Resposta:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    currentCard['answer'] ?? '',
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showAnswer = !_showAnswer;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child:
                  Text(_showAnswer ? 'Ocultar Resposta' : 'Mostrar Resposta'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed:
                      _checkDailyLimit, // Chama a função de verificação de limite
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text('Difícil'),
                ),
                ElevatedButton(
                  onPressed:
                      _checkDailyLimit, // Chama a função de verificação de limite
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: Text('Bom'),
                ),
                ElevatedButton(
                  onPressed:
                      _checkDailyLimit, // Chama a função de verificação de limite
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
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
