import 'package:flutter/material.dart';

class EditCardScreen extends StatefulWidget {
  final String question;
  final String answer;

  EditCardScreen({required this.question, required this.answer});

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
      appBar: AppBar(title: Text('Editar Card')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _questionController,
              decoration: InputDecoration(labelText: 'Pergunta'),
            ),
            TextField(
              controller: _answerController,
              decoration: InputDecoration(labelText: 'Resposta'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop({
                  'question': _questionController.text,
                  'answer': _answerController.text,
                });
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
