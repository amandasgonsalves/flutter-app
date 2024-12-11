import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ProfileScreen extends StatelessWidget {
  final String userName; // Variável que receberá o nome do usuário

  ProfileScreen({super.key})
      : userName = Hive.box('users').get('user_name',
            defaultValue:
                'Seu Nome'); // Pega o nome do Hive ou usa um valor padrã
  final int decksCount = 5; // Número de baralhos
  final int streakDays = 10; // Dias de revisão consecutivos
  final int reviewedCardsToday = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Voltar para a tela anterior
          },
        ),
        backgroundColor: const Color(0xFFA0D3E8), // Azul pastel claro
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagem do usuário
            const CircleAvatar(
              radius: 50,
              backgroundImage:
                  AssetImage('assets/user_avatar.png'), // Imagem do usuário
            ),
            const SizedBox(height: 16), // Espaçamento
            // Nome do usuário
            Text(
              userName,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'),
            ),
            const SizedBox(height: 16),
            // Informações sobre baralhos e dias de ofensiva
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text('Baralhos',
                        style: TextStyle(fontFamily: 'Poppins')),
                    Text('$decksCount',
                        style: const TextStyle(
                            fontSize: 18, fontFamily: 'Poppins')),
                  ],
                ),
                Column(
                  children: [
                    const Text('Dias de Ofensiva',
                        style: TextStyle(fontFamily: 'Poppins')),
                    Text('$streakDays',
                        style: const TextStyle(
                            fontSize: 18, fontFamily: 'Poppins')),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Grade do calendário
            Expanded(
              child:
                  CalendarView(), // Um widget que você criará para mostrar a grade
            ),
            const SizedBox(height: 16),
            // Texto sobre cards revisados hoje
            Text(
              'Você revisou $reviewedCardsToday cards hoje!',
              style: const TextStyle(fontFamily: 'Poppins'),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget simulado para a grade do calendário
class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7, // 7 colunas para os dias da semana
        childAspectRatio: 1, // Aspecto quadrado para cada dia
      ),
      itemCount: 30, // Número de dias no mês (pode ser ajustado)
      itemBuilder: (context, index) {
        // Aqui você pode definir quais dias estão marcados em azul/verde
        bool hasReviewed = (index % 3 == 0); // Exemplo: marca cada 3 dias
        return Container(
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: hasReviewed
                ? Colors.blue[200]
                : Colors.grey[300], // Azul pastel para dias revisados
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold), // Fonte fofa
            ), // Mostra o número do dia
          ),
        );
      },
    );
  }
}
