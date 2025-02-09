import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  int _dailyLimit = 0;
  int _maxReviewCards = 0;

  @override
  void initState() {
    super.initState();
    _loadSettings(); // Carregar as configurações salvas ao iniciar
  }

  void _loadSettings() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int dailyLimit = prefs.getInt('dailyLimit') ?? 0;
      int maxReviewCards = prefs.getInt('maxReviewCards') ?? 0;

      if (mounted) {
        setState(() {
          _dailyLimit = dailyLimit;
          _maxReviewCards = maxReviewCards;
          _dailyLimitController.text = dailyLimit.toString();
          _maxReviewCardsController.text = maxReviewCards.toString();
        });
      }
    } catch (e, stackTrace) {
      print('Erro ao carregar as configurações: $e');
      print(stackTrace); // Imprime o stack trace para mais detalhes

      // Exibe a mensagem de erro para o usuário
      if (mounted) {
        setState(() {
          _dailyLimit = 0; // Valor padrão em caso de erro
          _dailyLimitController.text =
              '0'; // Atualiza o campo com o valor padrão
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao carregar as configurações: $e'),
        ),
      );
    }
  }

  // Função assíncrona para salvar as configurações
  void _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
        'dailyLimit', _dailyLimit); // Salvar o limite de revisões
    await prefs.setInt('maxReviewCards',
        _maxReviewCards); // Salvar o limite de criação de cartões
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Configurações salvas com sucesso!')),
    );
  }

  // Validação para garantir que o número seja válido
  String? _validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    final number = int.tryParse(value);
    if (number == null || number <= 0) {
      return 'Digite um número válido e maior que 0';
    }
    return null;
  }

  // Atualiza o limite diário e o limite de criação de cartões
  void _setDailyLimit(String value) {
    final parsedValue = int.tryParse(value);
    if (parsedValue != null && parsedValue > 0) {
      setState(() {
        _dailyLimit = parsedValue;
      });
    }
  }

  void _setMaxReviewCards(String value) {
    final parsedValue = int.tryParse(value);
    if (parsedValue != null && parsedValue > 0) {
      setState(() {
        _maxReviewCards = parsedValue;
      });
    }
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
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        color: Colors.lightBlue[50],
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTextField(
              controller: _dailyLimitController,
              label: 'Limite de revisões diárias',
              validator: _validateNumber,
              onChanged: (value) => _setDailyLimit(value),
            ),
            _buildTextField(
              controller: _maxReviewCardsController,
              label: 'Máximo de cartões criados por dia',
              validator: _validateNumber,
              onChanged: (value) => _setMaxReviewCards(value),
            ),
            _buildTextField(
              controller: _difficultIntervalController,
              label: 'Intervalo de dias para DIFICIL',
              validator: _validateNumber,
            ),
            _buildTextField(
              controller: _goodIntervalController,
              label: 'Intervalo de dias para BOM',
              validator: _validateNumber,
            ),
            _buildTextField(
              controller: _easyIntervalController,
              label: 'Intervalo de dias para FÁCIL',
              validator: _validateNumber,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final maxReviewCards =
                    int.tryParse(_maxReviewCardsController.text) ?? 0;
                if (maxReviewCards > _dailyLimit) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'O número máximo de cartões não pode ultrapassar o limite diário.'),
                    ),
                  );
                } else {
                  _saveSettings(); // Salvar as configurações
                  Navigator.pop(context); // Voltar à tela anterior após salvar
                }
              },
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

  // Função para construir o campo de texto
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
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
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}
