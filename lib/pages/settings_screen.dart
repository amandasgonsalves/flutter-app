import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Volta para a tela anterior
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Botão de Personalizar Estudo
            ElevatedButton(
              onPressed: () {
                // Lógica para personalizar estudo
              },
              child: Text('Personalizar Estudo'),
            ),
            SizedBox(height: 16),

            // Botão de Configurações de Perfil
            ElevatedButton(
              onPressed: () {
                // Lógica para configurações de perfil
              },
              child: Text('Configurações de Perfil'),
            ),
            SizedBox(height: 16),

            // Botão de Preferências de Notificações
            ElevatedButton(
              onPressed: () {
                // Lógica para preferências de notificações
              },
              child: Text('Preferências de Notificações'),
            ),
            SizedBox(height: 16),

            // Botão de Sair
            ElevatedButton(
              onPressed: () {
                // Lógica para sair
              },
              child: Text('Sair'),
            ),
          ],
        ),
      ),
    );
  }
}
