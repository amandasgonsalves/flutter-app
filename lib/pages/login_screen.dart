import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:crypto/crypto.dart'; // Para hash de senha
import 'dart:convert';
import 'home_screen.dart'; // Certifique-se de que esse arquivo esteja presente

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Função para realizar o login
  void _login(BuildContext context) async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    // Validação de e-mail e senha
    if (!_isValidEmail(username)) {
      _showErrorDialog(context, 'Por favor, insira um e-mail válido.');
      return;
    }

    if (!_isValidPassword(password)) {
      _showErrorDialog(context, 'A senha deve ter pelo menos 6 caracteres.');
      return;
    }

    // Abertura da box no Hive
    var box = await Hive.openBox('users');

    // Recuperando o usuário
    var user = box.get(username);

    if (user != null) {
      // Verifica se o hash da senha fornecida corresponde ao hash armazenado
      String hashedPassword = _hashPassword(password);

      if (user['password'] == hashedPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login bem-sucedido!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuário ou senha inválidos!')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuário não encontrado!')),
      );
    }
  }

  // Função para verificar o formato do e-mail
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  // Função para validar a senha
  bool _isValidPassword(String password) {
    return password.length >= 6;
  }

  // Função para mostrar o erro
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

  // Função para criar hash da senha
  String _hashPassword(String password) {
    var bytes = utf8.encode(password); // Codificando senha
    var digest = sha256.convert(bytes); // Gerando hash SHA256
    return digest.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(fontFamily: 'Poppins')),
        backgroundColor: Color(0xFFA0D3E8),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Campo de e-mail (ou nome de usuário)
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                filled: true,
                fillColor: Color(0xFFE8F5FA),
              ),
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            SizedBox(height: 16.0),
            // Campo de senha
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                filled: true,
                fillColor: Color(0xFFE8F5FA),
              ),
              obscureText: true,
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            SizedBox(height: 20),
            // Botão de login
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Login', style: TextStyle(fontFamily: 'Poppins')),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6BB7E2),
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
