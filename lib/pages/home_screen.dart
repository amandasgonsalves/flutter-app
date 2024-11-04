import 'package:flutter/material.dart';
import 'create_deck_screen.dart'; // Certifique-se de que o caminho está correto

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _deckNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Função para mostrar o pop-up de criação de baralho
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
                // Fecha o diálogo e navega para a tela de criação de cards
                Navigator.of(context).pop(); // Fechar o pop-up
                _navigateToCreateDeckScreen();
              },
            ),
          ],
        );
      },
    );
  }

  // Navega para a tela de criação de cards, passando o nome e a descrição do baralho
  void _navigateToCreateDeckScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateDeckScreen(
          deckName: _deckNameController.text,
          description: _descriptionController.text,
        ),
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
      body: Center(
        child: ElevatedButton(
          onPressed: _showCreateDeckDialog,
          child: Text('Criar Baralho'),
        ),
      ),
    );
  }
}
