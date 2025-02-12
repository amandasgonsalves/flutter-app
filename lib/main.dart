import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_screen.dart';
import 'package:flutter_application_1/pages/login_screen.dart';
import 'package:flutter_application_1/pages/signup_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('users');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hive Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/home',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
