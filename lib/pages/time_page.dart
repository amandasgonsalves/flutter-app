import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/time.dart';

class TimePage extends StatefulWidget {
  final Time time;

  // Tornando o Key opcional
  TimePage({Key? key, required this.time}) : super(key: key);

  @override
  State<TimePage> createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.time.cor,
        title: Text(widget.time.nome),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Time: ${widget.time.nome}', style: TextStyle(fontSize: 24)),
            SizedBox(height: 10),
            Text('Pontos: ${widget.time.pontos}',
                style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
