import 'package:flutter/material.dart';
import 'login_screen.dart'; // Importe sua tela de login

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Personalizar Estudo'),
            onTap: () {
              // Adicione a lógica para personalizar estudo
            },
          ),
          ListTile(
            title: Text('Configurações de Perfil'),
            onTap: () {
              // Adicione a lógica para configurações de perfil
            },
          ),
          ListTile(
            title: Text('Sair'),
            onTap: () {
              // Navega de volta para a tela de login
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false, // Remove todas as rotas anteriores
              );
            },
          ),
        ],
      ),
    );
  }
}
