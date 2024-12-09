import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Usuário'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var box = Hive.box('users');
                String username = _usernameController.text;
                String password = _passwordController.text;

                if (box.containsKey(username)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Usuário já existe!')),
                  );
                } else {
                  box.put(username, password); // Salva o usuário e a senha
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Cadastro realizado com sucesso!')),
                  );
                  Navigator.pop(context); // Retorna à tela de login
                }
              },
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
