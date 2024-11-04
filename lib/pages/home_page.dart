import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/time.dart';
import 'package:flutter_application_1/pages/home_controller.dart';
import 'package:flutter_application_1/pages/time_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController controller; // Usando late para garantir a inicialização

  @override
  void initState() {
    super.initState();
    controller = HomeController(); // Inicializando o controlador
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AMANDA'),
      ),
      body: ListView.separated(
        itemCount: controller.tabela.length,
        itemBuilder: (BuildContext context, int index) {
          final List<Time> tabela = controller.tabela;
          return ListTile(
            leading: Image.network(tabela[index].brasao),
            title: Text(tabela[index].nome),
            trailing: Text(
              tabela[index].pontos.toString(),
            ),
            onTap: () {
              debugPrint(
                  'Navegando para: ${tabela[index].nome}'); // Debug para navegação
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TimePage(
                    key: Key(tabela[index].nome),
                    time: tabela[index],
                  ),
                ),
              );
            },
          );
        },
        separatorBuilder: (_, __) => Divider(),
        padding: EdgeInsets.all(16),
      ),
    );
  }
}
