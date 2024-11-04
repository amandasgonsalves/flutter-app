import 'package:flutter/material.dart';

class CreateDeckScreen extends StatefulWidget {
  final String deckName;
  final String description;

  CreateDeckScreen({required this.deckName, required this.description});

  @override
  _CreateDeckScreenState createState() => _CreateDeckScreenState();
}

class _CreateDeckScreenState extends State<CreateDeckScreen> {
  final List<Map<String, String>> _cards = [];
  final TextEditingController _frontController = TextEditingController();
  final TextEditingController _backController = TextEditingController();

  // Função para mostrar o pop-up de adicionar card
  void _showAddCardDialog() {
    _frontController.clear();
    _backController.clear();

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
                decoration: InputDecoration(labelText: 'Frente do Card'),
              ),
              TextField(
                controller: _backController,
                decoration: InputDecoration(labelText: 'Verso do Card'),
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
                if (_frontController.text.isNotEmpty &&
                    _backController.text.isNotEmpty) {
                  setState(() {
                    _cards.add({
                      'front': _frontController.text,
                      'back': _backController.text,
                    });
                  });
                  Navigator.of(context).pop();
                }
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
        title: Text(widget.deckName), // Exibe o nome do baralho no AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _showAddCardDialog,
              child: Text('Adicionar Card'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _cards.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_cards[index]['front'] ?? ''),
                  subtitle: Text(_cards[index]['back'] ?? ''),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
