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
  List<DateTime?> _reviewDates =
      []; // Para armazenar as datas de revisão dos cards

  @override
  void initState() {
    super.initState();
    _shuffleCards();
    _currentIndex = 0;
    _initializeReviewDates();
  }

  void _shuffleCards() {
    widget.cards.shuffle(Random()); // Embaralha os cards
  }

  void _initializeReviewDates() {
    // Inicializa as datas de revisão como nulas
    _reviewDates = List.generate(widget.cards.length, (index) => null);
  }

  void _nextCard() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % widget.cards.length;
      _showFront = true;
    });
  }

  void _setReviewDate(String difficulty) {
    DateTime nextReviewDate;

    switch (difficulty) {
      case 'DIFÍCIL':
        nextReviewDate =
            DateTime.now().add(Duration(days: 0)); // Revisar novamente no final
        break;
      case 'BOM':
        nextReviewDate =
            DateTime.now().add(Duration(days: 1)); // Revisar em 24h
        break;
      case 'FÁCIL':
        nextReviewDate =
            DateTime.now().add(Duration(days: 2)); // Revisar em 48h
        break;
      default:
        return;
    }

    setState(() {
      _reviewDates[_currentIndex] =
          nextReviewDate; // Atualiza a data de revisão do card atual
    });

    _nextCard(); // Avança para o próximo card
  }

  @override
  Widget build(BuildContext context) {
    // Filtra os cards para mostrar apenas os que precisam ser revisados
    final availableCards = widget.cards.asMap().entries.where((entry) {
      final index = entry.key;
      final card = entry.value;
      final reviewDate = _reviewDates[index];

      return reviewDate == null || DateTime.now().isAfter(reviewDate);
    }).toList();

    if (availableCards.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Revisão')),
        body: Center(
          child: Text('Nenhum card para revisar!'),
        ),
      );
    }

    final card = availableCards[_currentIndex].value;

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
