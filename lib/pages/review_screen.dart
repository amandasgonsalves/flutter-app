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

  @override
  void initState() {
    super.initState();
    _shuffleCards();
    _currentIndex = 0;
  }

  void _shuffleCards() {
    widget.cards.shuffle(Random()); // Embaralha os cards
  }

  void _nextCard() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % widget.cards.length;
      _showFront = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cards.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Revisão')),
        body: Center(
          child: Text('Nenhum card para revisar!'),
        ),
      );
    }

    final card = widget.cards[_currentIndex];
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
      floatingActionButton: FloatingActionButton(
        onPressed: _nextCard,
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
