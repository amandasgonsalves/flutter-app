import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'edit_profile_screen.dart';
import 'customize_study_screen.dart'; // Importe a nova tela

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Configurações',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        backgroundColor: const Color(0xFFA0D3E8), // Azul pastel claro
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: const Text(
                'Personalizar Estudo',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
              ),
              tileColor: Colors.blue[50], // Fundo pastel
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CustomizeStudyScreen()),
                );
              },
            ),
            const SizedBox(height: 16), // Espaçamento entre os itens
            ListTile(
              title: const Text(
                'Configurações de Perfil',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
              ),
              tileColor: Colors.blue[50], // Fundo pastel
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfileScreen()),
                );
              },
            ),
            const SizedBox(height: 16), // Espaçamento entre os itens
            ListTile(
              title: const Text(
                'Sair',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
              ),
              tileColor: Colors.blue[50], // Fundo pastel
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
