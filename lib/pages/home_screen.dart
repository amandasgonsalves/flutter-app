import 'package:flutter/material.dart';
import 'create_deck_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> _decks =
      []; // Lista para armazenar os baralhos

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
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToCreateDeckScreen(String deckName, String description) async {
    final newDeck = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateDeckScreen(
          deckName: deckName,
          description: description,
        ),
      ),
    );

    if (newDeck != null && newDeck['name'] != null) {
      setState(() {
        _decks.add(newDeck);
      });
    }
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
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProfileScreen()), // Navega para a tela de perfil
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SettingsScreen()), // Navega para a tela de configurações
              );
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
                  subtitle: Text(deck['description'] ?? 'Sem descrição'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // Iniciar o estudo do baralho
                    },
                    child: Text('GO'),
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
