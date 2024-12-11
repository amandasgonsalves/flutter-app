import 'package:flutter/material.dart';
import 'edit_card_screen.dart';

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
      appBar: AppBar(
        title: const Text(
          'Criar Baralho',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent, // Cor da AppBar
      ),
      body: Container(
        color: Colors.lightBlue[50], // Cor de fundo do corpo
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
                      backgroundColor:
                          Colors.green, // Cor do botão "Adicionar Card"
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30), // Bordas arredondadas
                      ),
                    ),
                    child: const Text('Adicionar Card',
                        style: TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop({
                        'name': widget.deckName,
                        'description': widget.description,
                        'cards': _cards,
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.blue, // Cor do botão "Salvar Baralho"
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30), // Bordas arredondadas
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
