import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController(text: widget.question);
    _answerController = TextEditingController(text: widget.answer);
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
        backgroundColor: Colors.blueAccent, // Cor da AppBar
      ),
      body: Container(
        color: Colors.lightBlue[50], // Cor de fundo do corpo
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
            const SizedBox(height: 16), // Espaçamento entre os campos
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
              onPressed: () {
                Navigator.of(context).pop({
                  'question': _questionController.text,
                  'answer': _answerController.text,
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Cor do botão "Salvar"
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(30), // Bordas arredondadas
                ),
              ),
              child: const Text(
                'Salvar',
                style: TextStyle(fontSize: 18), // Aumentar o tamanho da fonte
              ),
            ),
          ],
        ),
      ),
    );
  }
}
