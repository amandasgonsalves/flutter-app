import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo para o nome
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            SizedBox(height: 16.0),
            // Campo para o nome de usuário
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Usuário'),
            ),
            SizedBox(height: 16.0),
            // Campo para a senha
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            // Campo para confirmar a senha
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirmar Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            // Botão de cadastro
            ElevatedButton(
              onPressed: () async {
                String name = _nameController.text;
                String username = _usernameController.text;
                String password = _passwordController.text;
                String confirmPassword = _confirmPasswordController.text;

                if (name.isEmpty ||
                    username.isEmpty ||
                    password.isEmpty ||
                    confirmPassword.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Preencha todos os campos!')));
                  return;
                }

                if (password != confirmPassword) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('As senhas não coincidem!')));
                  return;
                }

                var box = await Hive.openBox('users');
                if (box.containsKey(username)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Usuário já existe!')));
                } else {
                  var hashedPassword = _hashPassword(password);
                  box.put(username, {'name': name, 'password': hashedPassword});
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Cadastro realizado com sucesso!')));
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }

  // Função para gerar o hash da senha
  String _hashPassword(String password) {
    return password; // Lógica de hashing aqui
  }
}
