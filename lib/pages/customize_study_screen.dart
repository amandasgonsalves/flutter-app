import 'package:flutter/material.dart';

class CustomizeStudyScreen extends StatefulWidget {
  const CustomizeStudyScreen({super.key});

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
        title: const Text(
          'Personalizar Estudo',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent, // Cor da AppBar
      ),
      body: Container(
        color: Colors.lightBlue[50], // Cor de fundo do corpo
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTextField(
              controller: _dailyLimitController,
              label: 'Limite de cartões por dia',
            ),
            _buildTextField(
              controller: _maxReviewCardsController,
              label: 'Máximo de cartões para revisão',
            ),
            _buildTextField(
              controller: _difficultIntervalController,
              label: 'Intervalo de dias para DIFICIL',
            ),
            _buildTextField(
              controller: _goodIntervalController,
              label: 'Intervalo de dias para BOM',
            ),
            _buildTextField(
              controller: _easyIntervalController,
              label: 'Intervalo de dias para FÁCIL',
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para salvar as configurações
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.white),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text('Configurações salvas com sucesso!'),
                        ),
                      ],
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pop(context);
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.blueAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.blue),
          ),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
