import 'package:flutter/material.dart';
import 'create_deck_screen.dart';
import 'review_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _decks = []; // Lista de baralhos

  final TextEditingController _deckNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _showCreateDeckDialog() {
    _deckNameController.clear();
    _descriptionController.clear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Criar Novo Baralho'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _deckNameController,
                decoration: InputDecoration(labelText: 'Nome do Baralho'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descrição (opcional)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Criar'),
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

  void _navigateToCreateDeckScreen(String deckName, String description,
      List<Map<String, String>> cards) async {
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
        final existingDeckIndex =
            _decks.indexWhere((deck) => deck['name'] == updatedDeck['name']);
        if (existingDeckIndex >= 0) {
          _decks[existingDeckIndex] =
              updatedDeck; // Atualiza o baralho existente
        } else {
          _decks.add(updatedDeck); // Adiciona novo baralho
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
        title: Text('BARALHOS'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Navegar para a tela de perfil
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navegar para a tela de configurações
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _decks.length,
              itemBuilder: (context, index) {
                final deck = _decks[index];
                return ListTile(
                  title: Text(deck['name'] ?? 'Nome do Baralho'),
                  subtitle: Text('${deck['description'] ?? 'Sem descrição'}\n'
                      'Cards: ${deck['cardCount'] ?? '0'}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _navigateToReviewScreen(deck['cards'] ?? []);
                        },
                        child: Text('GO'), // Botão para a tela de revisão
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          _navigateToCreateDeckScreen(
                            deck['name'],
                            deck['description'],
                            deck['cards'] ?? [],
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _showCreateDeckDialog,
            child: Text('Criar Baralho'),
          ),
        ],
      ),
    );
  }
}
