import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/profile_screen.dart';
import 'create_deck_screen.dart';
import 'review_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _decks = [
    {
      'name': 'Baralho de Matemática',
      'description': 'Operações básicas e álgebra',
      'cardCount': 10,
      'cards': [
        {'question': '2 + 2', 'answer': '4'},
        {'question': '3 x 3', 'answer': '9'},
      ],
    },
    {
      'name': 'Baralho de Ciência',
      'description': 'Conceitos básicos de física e química',
      'cardCount': 8,
      'cards': [
        {'question': 'Qual a fórmula da água?', 'answer': 'H2O'},
        {'question': 'Qual é a velocidade da luz?', 'answer': '299,792 km/s'},
      ],
    },
    {
      'name': 'Baralho de História',
      'description': 'Fatos importantes do século XX',
      'cardCount': 5,
      'cards': [
        {
          'question': 'Em que ano ocorreu a Primeira Guerra Mundial?',
          'answer': '1914'
        },
        {
          'question': 'Quem foi o presidente dos EUA em 1963?',
          'answer': 'John F. Kennedy'
        },
      ],
    },
  ];

  final TextEditingController _deckNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _showCreateDeckDialog() {
    _deckNameController.clear();
    _descriptionController.clear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Criar Novo Baralho',
              style: TextStyle(fontFamily: 'Poppins')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _deckNameController,
                decoration: const InputDecoration(labelText: 'Nome do Baralho'),
              ),
              TextField(
                controller: _descriptionController,
                decoration:
                    const InputDecoration(labelText: 'Descrição (opcional)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Criar'),
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToCreateDeckScreen(
                  _deckNameController.text,
                  _descriptionController.text,
                  [],
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToCreateDeckScreen(
      String deckName, String description, List<Map<String, String>> cards,
      {bool isEditing = false}) async {
    final updatedDeck = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateDeckScreen(
          deckName: deckName,
          description: description,
          initialCards: cards,
        ),
      ),
    );

    if (updatedDeck != null) {
      setState(() {
        if (isEditing) {
          final index = _decks.indexWhere((deck) => deck['name'] == deckName);
          if (index >= 0) {
            _decks[index] = updatedDeck;
          }
        } else {
          _decks.add(updatedDeck);
        }
      });
    }
  }

  void _navigateToReviewScreen(List<Map<String, String>> cards) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewScreen(cards: cards),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BARALHOS', style: TextStyle(fontFamily: 'Poppins')),
        backgroundColor: const Color(0xFFA0D3E8), // Azul pastel claro
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _decks.length,
                itemBuilder: (context, index) {
                  final deck = _decks[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(deck['name'] ?? 'Nome do Baralho',
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          '${deck['description'] ?? 'Sem descrição'}\n'
                          'Cards: ${deck['cardCount'] ?? '0'}',
                          style: const TextStyle(fontFamily: 'Poppins')),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              _navigateToCreateDeckScreen(
                                deck['name'],
                                deck['description'],
                                deck['cards'] ?? [],
                                isEditing: true,
                              );
                            },
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _navigateToReviewScreen(deck['cards'] ?? []);
                            },
                            child: const Text('GO'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16), // Espaçamento antes do botão
            ElevatedButton(
              onPressed: _showCreateDeckDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA0D3E8), // Azul pastel claro
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Criar Baralho',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
