import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditCardScreen extends StatefulWidget {
  final String question;
  final String answer;

  const EditCardScreen(
      {super.key, required this.question, required this.answer});

  @override
  _EditCardScreenState createState() => _EditCardScreenState();
}

class _EditCardScreenState extends State<EditCardScreen> {
  late TextEditingController _questionController;
  late TextEditingController _answerController;
  int _dailyLimit = 0;
  int _cardsCreated = 0; // Contador de cartões criados

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController(text: widget.question);
    _answerController = TextEditingController(text: widget.answer);
    _loadDailyLimit();
  }

  // Carrega o limite diário de cartões
  Future<void> _loadDailyLimit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _dailyLimit =
          prefs.getInt('dailyLimit') ?? 0; // Recupera o limite de cartões
    });
  }

  // Verifica se o limite diário foi atingido
  Future<void> _checkCardLimit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentCardsCreated = prefs.getInt('cardsCreated') ?? 0;
    if (currentCardsCreated >= _dailyLimit) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Você atingiu o limite diário de criação de cartões.'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      _saveCard();
    }
  }

  // Função para salvar o cartão
  Future<void> _saveCard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Atualiza o contador de cartões criados
    int newCardsCreated = (_cardsCreated + 1);
    prefs.setInt('cardsCreated', newCardsCreated);

    // Salva os dados do cartão criado
    Navigator.of(context).pop({
      'question': _questionController.text,
      'answer': _answerController.text,
    });
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Editar Card',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        color: Colors.lightBlue[50],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _questionController,
              decoration: InputDecoration(
                labelText: 'Pergunta',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.blueAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _answerController,
              decoration: InputDecoration(
                labelText: 'Resposta',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.blueAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkCardLimit, // Verifica o limite antes de salvar
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Salvar',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
