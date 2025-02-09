import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'home_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

    // Verifica as credenciais no Hive
    if (box.containsKey(username)) {
      var user = box.get(username);
      var hashedPassword = _hashPassword(password);

      if (user['password'] == hashedPassword) {
        // Armazenar sessão após login
        var sessionBox = await Hive.openBox('session');
        sessionBox.put('username', username);

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

  // Função para gerar o hash da senha
  String _hashPassword(String password) {
    return password; // Aqui você pode aplicar a lógica de hashing
  }

  // Função para mostrar o erro
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Erro'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
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
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Campo de e-mail
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'E-mail'),
            ),
            SizedBox(height: 16.0),
            // Campo de senha
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            // Botão de login
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Login'),
            ),
            SizedBox(height: 10),
            // Link para a tela de cadastro
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              },
              child: Text('Não tem uma conta? Cadastre-se!'),
            ),
          ],
        ),
      ),
    );
  }
}
