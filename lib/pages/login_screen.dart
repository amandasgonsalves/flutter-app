import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'signup_screen.dart'; // Certifique-se de importar a tela de cadastro

class LoginScreen extends StatelessWidget {
  // Controladores de texto para capturar os dados de entrada
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aqui você pode adicionar sua lógica de autenticação
                // Se a autenticação for bem-sucedida, navegue para a tela de baralhos
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HomeScreen()), // Navega para a tela de baralhos
                );
              },
              child: Text('Login'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Navegar para a tela de cadastro
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SignupScreen()), // Navega para a tela de cadastro
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
