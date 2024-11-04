import 'package:flutter/material.dart';

class CreateDeckScreen extends StatefulWidget {
  final String deckName;
  final String description;
  final List<Map<String, String>>
      initialCards; // Recebe uma lista de cards já existentes

  CreateDeckScreen({
    required this.deckName,
    required this.description,
    this.initialCards = const [],
  });

  @override
  _CreateDeckScreenState createState() => _CreateDeckScreenState();
}

class _CreateDeckScreenState extends State<CreateDeckScreen> {
  List<Map<String, String>> _cards = []; // Armazena os cards do baralho

  @override
  void initState() {
    super.initState();
    _cards =
        widget.initialCards; // Inicializa com os cards existentes, se houver
  }

  void _showAddCardDialog() {
    final TextEditingController _frontController = TextEditingController();
    final TextEditingController _backController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adicionar Card'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _frontController,
                decoration: InputDecoration(labelText: 'Frente'),
              ),
              TextField(
                controller: _backController,
                decoration: InputDecoration(labelText: 'Verso'),
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
              child: Text('Adicionar'),
              onPressed: () {
                setState(() {
                  _cards.add({
                    'front': _frontController.text,
                    'back': _backController.text,
                  });
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.deckName),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Retorna nome, descrição e quantidade de cards atualizada
            Navigator.of(context).pop({
              'name': widget.deckName,
              'description': widget.description,
              'cardCount': _cards.length.toString(),
              'cards': _cards, // Inclui os cards atualizados
            });
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _cards.length,
              itemBuilder: (context, index) {
                final card = _cards[index];
                return ListTile(
                  title: Text(card['front'] ?? ''),
                  subtitle: Text(card['back'] ?? ''),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _showAddCardDialog,
            child: Text('Adicionar Card'),
          ),
        ],
      ),
    );
  }
}
