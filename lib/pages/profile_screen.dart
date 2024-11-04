import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String userName = "Seu Nome"; // Substitua pelo nome do usuário
  final int decksCount = 5; // Número de baralhos
  final int streakDays = 10; // Dias de revisão consecutivos
  final int reviewedCardsToday = 3; // Número de cards revisados hoje

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Voltar para a tela anterior
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagem do usuário
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  AssetImage('assets/user_avatar.png'), // Imagem do usuário
              // Certifique-se de ter uma imagem com esse nome na pasta assets
            ),
            SizedBox(height: 16), // Espaçamento
            // Nome do usuário
            Text(
              userName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // Informações sobre baralhos e dias de ofensiva
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text('Baralhos'),
                    Text('$decksCount'),
                  ],
                ),
                Column(
                  children: [
                    Text('Dias de Ofensiva'),
                    Text('$streakDays'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            // Grade do calendário
            Expanded(
              child:
                  CalendarView(), // Um widget que você criará para mostrar a grade
            ),
            SizedBox(height: 16),
            // Texto sobre cards revisados hoje
            Text('Você revisou $reviewedCardsToday cards hoje!'),
          ],
        ),
      ),
    );
  }
}

// Widget simulado para a grade do calendário
class CalendarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7, // 7 colunas para os dias da semana
        childAspectRatio: 1, // Aspecto quadrado para cada dia
      ),
      itemCount: 30, // Número de dias no mês (pode ser ajustado)
      itemBuilder: (context, index) {
        // Aqui você pode definir quais dias estão marcados em azul/verde
        bool hasReviewed = (index % 3 == 0); // Exemplo: marca cada 3 dias
        return Container(
          margin: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: hasReviewed ? Colors.blue : Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text('${index + 1}'), // Mostra o número do dia
          ),
        );
      },
    );
  }
}
