import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

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
              decoration: InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                filled: true,
                fillColor: Color(0xFFE8F5FA), // Azul claro
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              ),
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            SizedBox(height: 16.0),
            // Campo para o nome de usuário
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Usuário',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                filled: true,
                fillColor: Color(0xFFE8F5FA), // Azul claro
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              ),
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            SizedBox(height: 16.0),
            // Campo para a senha
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                filled: true,
                fillColor: Color(0xFFE8F5FA), // Azul claro
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              ),
              obscureText: true,
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            SizedBox(height: 20),
            // Botão de cadastro
            ElevatedButton(
              onPressed: () async {
                var box = Hive.box('users');
                String username = _usernameController.text;
                String name = _nameController.text;
                String password = _passwordController.text;

                if (box.containsKey(username)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Usuário já existe!')),
                  );
                } else {
                  box.put(username, password); // Salva o usuário e a senha
                  box.put('user_name', name); // Salva o nome do usuário
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Cadastro realizado com sucesso!')),
                  );
                  Navigator.pop(context); // Retorna à tela de login
                }
              },
              child: Text('Cadastrar', style: TextStyle(fontFamily: 'Poppins')),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6BB7E2), // Azul pastel médio
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
