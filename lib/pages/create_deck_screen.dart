import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'edit_card_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CreateDeckScreen extends StatefulWidget {
  final String deckName;
  final String description;
  final List<Map<String, String>> initialCards;

  const CreateDeckScreen({
    super.key,
    required this.deckName,
    required this.description,
    required this.initialCards,
  });

  @override
  _CreateDeckScreenState createState() => _CreateDeckScreenState();
}

class _CreateDeckScreenState extends State<CreateDeckScreen> {
  late List<Map<String, String>> _cards;
  late Box _deckBox;

  @override
  void initState() {
    super.initState();
    _cards = widget.initialCards;
    _initializeHive();
  }

  void _initializeHive() async {
    await Hive.initFlutter();
    _deckBox = await Hive.openBox('decks');
  }

  void _saveDeck() {
    final newDeck = {
      'name': widget.deckName,
      'description': widget.description,
      'cards': _cards,
    };

    _deckBox.add(newDeck); // Salva no Hive
    Navigator.of(context).pop(newDeck);
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
      appBar: AppBar(
        title: const Text(
          'Criar Baralho',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        color: Colors.lightBlue[50],
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _cards.length,
                itemBuilder: (context, index) {
                  final card = _cards[index];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 4,
                    child: ListTile(
                      title: Text(
                        card['question'] ?? 'Pergunta',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        card['answer'] ?? 'Resposta',
                        style: const TextStyle(fontSize: 16),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _editCard(index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _addNewCard,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Adicionar Card',
                        style: TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _saveDeck,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Salvar Baralho',
                        style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
