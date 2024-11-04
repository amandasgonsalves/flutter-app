import 'package:flutter/material.dart';
import 'dart:math';

class ReviewScreen extends StatefulWidget {
  final List<Map<String, String>> cards;

  ReviewScreen({required this.cards});

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  late int _currentIndex;
  bool _showFront = true;
  List<int> _reviewCounts =
      []; // Quantas vezes cada card ainda precisa aparecer

  @override
  void initState() {
    super.initState();
    _shuffleCards();
    _currentIndex = 0;
    _initializeReviewCounts();
  }

  void _shuffleCards() {
    widget.cards.shuffle(Random()); // Embaralha os cards
  }

  void _initializeReviewCounts() {
    // Inicializa os contadores de revisões com 1 (para aparecer pelo menos uma vez)
    _reviewCounts = List.generate(widget.cards.length, (index) => 1);
  }

  void _nextCard() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _getAvailableCards().length;
      _showFront = true;
    });
  }

  void _setReviewDate(String difficulty) {
    int additionalReviews;

    switch (difficulty) {
      case 'DIFÍCIL':
        additionalReviews = 2; // Aparece mais duas vezes
        break;
      case 'BOM':
        additionalReviews = 1; // Aparece mais uma vez
        break;
      case 'FÁCIL':
        additionalReviews = 0; // Não aparece mais
        break;
      default:
        return;
    }

    setState(() {
      _reviewCounts[_currentIndex] =
          additionalReviews; // Define a contagem de revisões do card atual
      _nextCard(); // Avança para o próximo card
    });
  }

  List<Map<String, String>> _getAvailableCards() {
    // Filtra os cards para mostrar apenas os que ainda precisam ser revisados
    return widget.cards
        .asMap()
        .entries
        .where((entry) {
          final index = entry.key;
          return _reviewCounts[index] >
              0; // Apenas cards com contagem de revisões > 0
        })
        .map((entry) => entry.value)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final availableCards = _getAvailableCards();

    if (availableCards.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Revisão')),
        body: Center(
          child: Text('Nenhum card para revisar!'),
        ),
      );
    }

    final card = availableCards[_currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text('Revisão')),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _showFront = !_showFront;
            });
          },
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _showFront ? card['front'] ?? '' : card['back'] ?? '',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: _showFront
          ? FloatingActionButton(
              onPressed: _nextCard,
              child: Icon(Icons.arrow_forward),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _setReviewDate('DIFÍCIL'),
                  child: Text('Difícil'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _setReviewDate('BOM'),
                  child: Text('Bom'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _setReviewDate('FÁCIL'),
                  child: Text('Fácil'),
                ),
              ],
            ),
    );
  }
}
