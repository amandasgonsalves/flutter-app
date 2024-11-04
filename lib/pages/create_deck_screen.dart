import 'package:flutter/material.dart';

class CreateDeckScreen extends StatefulWidget {
  @override
  _CreateDeckScreenState createState() => _CreateDeckScreenState();
}

class _CreateDeckScreenState extends State<CreateDeckScreen> {
  final List<Map<String, dynamic>> _decks =
      []; // Lista para armazenar os baralhos
  final List<Map<String, String>> _cards = []; // Lista temporária para cards
  final TextEditingController _deckNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _showAddCardDialog() {
    final _frontController = TextEditingController();
    final _backController = TextEditingController();

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

  void _showCreateDeckDialog() {
    _deckNameController.clear();
    _descriptionController.clear();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Criar Baralho'),
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
                _createDeck();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _createDeck() {
    if (_deckNameController.text.isNotEmpty) {
      setState(() {
        _decks.add({
          'name': _deckNameController.text,
          'description': _descriptionController.text,
          'cards': List<Map<String, String>>.from(
              _cards), // Salva os cards no baralho
        });
        _cards.clear(); // Limpa os cards temporários após salvar
      });
      print(
          'Baralho criado: ${_deckNameController.text}, Cards: ${_decks.last['cards']}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Baralho'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: _showAddCardDialog,
              child: Text('Adicionar Card'),
            ),
            SizedBox(height: 16),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateDeckDialog,
        child: Icon(Icons.add),
        tooltip: 'Criar Baralho',
      ),
    );
  }
}
