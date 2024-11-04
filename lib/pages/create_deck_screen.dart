import 'package:flutter/material.dart';
import 'edit_card_screen.dart';

class CreateDeckScreen extends StatefulWidget {
  final String deckName;
  final String description;
  final List<Map<String, String>> initialCards;

  CreateDeckScreen({
    required this.deckName,
    required this.description,
    required this.initialCards,
  });

  @override
  _CreateDeckScreenState createState() => _CreateDeckScreenState();
}

class _CreateDeckScreenState extends State<CreateDeckScreen> {
  late List<Map<String, String>> _cards;

  @override
  void initState() {
    super.initState();
    _cards = widget.initialCards;
  }

  // Função para editar um card existente
  void _editCard(int index) async {
    final updatedCard = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditCardScreen(
          question: _cards[index]['question'] ?? '',
          answer: _cards[index]['answer'] ?? '',
        ),
      ),
    );

    if (updatedCard != null) {
      setState(() {
        _cards[index] = updatedCard;
      });
    }
  }

  // Função para adicionar um novo card
  void _addNewCard() async {
    final newCard = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditCardScreen(
          question: '',
          answer: '',
        ),
      ),
    );

    if (newCard != null) {
      setState(() {
        _cards.add(newCard);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Criar Baralho')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _cards.length,
              itemBuilder: (context, index) {
                final card = _cards[index];
                return ListTile(
                  title: Text(card['question'] ?? 'Pergunta'),
                  subtitle: Text(card['answer'] ?? 'Resposta'),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _editCard(index);
                    },
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _addNewCard,
                child: Text('Adicionar Card'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop({
                    'name': widget.deckName,
                    'description': widget.description,
                    'cards': _cards,
                  });
                },
                child: Text('Salvar Baralho'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
