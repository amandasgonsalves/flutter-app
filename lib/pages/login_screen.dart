import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(BuildContext context) {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Validações
    if (!_isValidEmail(email)) {
      _showErrorDialog(context, 'Por favor, insira um e-mail válido.');
      return;
    }
    if (!_isValidPassword(password)) {
      _showErrorDialog(context, 'A senha deve ter pelo menos 6 caracteres.');
      return;
    }

    // Se as validações forem bem-sucedidas, navegue para a tela de baralhos
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    return password.length >= 6;
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Erro', style: TextStyle(fontFamily: 'Poppins')),
          content: Text(message, style: TextStyle(fontFamily: 'Poppins')),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK', style: TextStyle(color: Color(0xFF4A90E2))),
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
        title: Text('Login', style: TextStyle(fontFamily: 'Poppins')),
        backgroundColor: Color(0xFFA0D3E8), // Azul pastel claro
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Imagem centralizada acima dos campos
            Center(
              child: Image.asset(
                'assets/flash_card.png', // Certifique-se de que este caminho esteja correto
                height: 100,
              ),
            ),
            SizedBox(height: 35), // Espaço entre a imagem e os campos
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                filled: true,
                fillColor: Color(0xFFE8F5FA), // Azul muito claro
                contentPadding: EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 20.0), // Ajuste do padding
              ),
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                filled: true,
                fillColor: Color(0xFFE8F5FA), // Azul muito claro
                contentPadding: EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 20.0), // Ajuste do padding
              ),
              obscureText: true,
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Login', style: TextStyle(fontFamily: 'Poppins')),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6BB7E2), // Azul pastel médio
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              },
              child: Text(
                'Não tem uma conta? Cadastre-se!',
                style: TextStyle(
                  color: Color(0xFF4A90E2), // Azul pastel mais escuro
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
