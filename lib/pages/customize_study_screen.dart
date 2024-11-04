import 'package:flutter/material.dart';

class CustomizeStudyScreen extends StatefulWidget {
  @override
  _CustomizeStudyScreenState createState() => _CustomizeStudyScreenState();
}

class _CustomizeStudyScreenState extends State<CustomizeStudyScreen> {
  final _dailyLimitController = TextEditingController();
  final _maxReviewCardsController = TextEditingController();
  final _difficultIntervalController = TextEditingController();
  final _goodIntervalController = TextEditingController();
  final _easyIntervalController = TextEditingController();

  @override
  void dispose() {
    _dailyLimitController.dispose();
    _maxReviewCardsController.dispose();
    _difficultIntervalController.dispose();
    _goodIntervalController.dispose();
    _easyIntervalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personalizar Estudo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _dailyLimitController,
              decoration:
                  InputDecoration(labelText: 'Limite de cartões por dia'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _maxReviewCardsController,
              decoration:
                  InputDecoration(labelText: 'Máximo de cartões para revisão'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _difficultIntervalController,
              decoration:
                  InputDecoration(labelText: 'Intervalo de dias para DIFICIL'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _goodIntervalController,
              decoration:
                  InputDecoration(labelText: 'Intervalo de dias para BOM'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _easyIntervalController,
              decoration:
                  InputDecoration(labelText: 'Intervalo de dias para FÁCIL'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para salvar as configurações
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Configurações salvas com sucesso!')),
                );
                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
