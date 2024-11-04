import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import 'create_deck_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> decks = [
    {
      'name': 'Baralho 1',
      'newCards': 3,
      'toLearn': 5,
      'toMemorize': 10,
    },
    {
      'name': 'Baralho 2',
      'newCards': 0,
      'toLearn': 2,
      'toMemorize': 7,
    },
    {
      'name': 'Baralho 3',
      'newCards': 4,
      'toLearn': 3,
      'toMemorize': 8,
    },
  ]; // Esta lista pode ser substituída por dados dinâmicos posteriormente.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Baralhos'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: decks.length,
                itemBuilder: (context, index) {
                  final deck = decks[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(deck['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '${deck['newCards']} novos cards nas últimas 24h'),
                          Text('Aprender: ${deck['toLearn']}'),
                          Text('Memorizar: ${deck['toMemorize']}'),
                        ],
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // Ação para começar a estudar este baralho
                        },
                        child: Text('GO'),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CreateDeckScreen()), // Navega para a tela de criar baralho
                );
              },
              child: Text('Criar Baralho'),
            ),
          ],
        ),
      ),
    );
  }
}
