import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'O nome é obrigatório';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'O e-mail é obrigatório';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Digite um e-mail válido';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'A senha é obrigatória';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Aqui você poderia realizar a ação de registro.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cadastro realizado com sucesso!')),
      );
      // Navega de volta para a tela de login
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Tela de Cadastro', style: TextStyle(fontFamily: 'Poppins')),
        backgroundColor: Color(0xFFA0D3E8), // Azul pastel claro
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  filled: true,
                  fillColor: Color(0xFFE8F5FA), // Azul muito claro
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20.0), // Ajuste do padding
                ),
                validator: _validateName,
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  filled: true,
                  fillColor: Color(0xFFE8F5FA), // Azul muito claro
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20.0), // Ajuste do padding
                ),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  filled: true,
                  fillColor: Color(0xFFE8F5FA), // Azul muito claro
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20.0), // Ajuste do padding
                ),
                obscureText: true,
                validator: _validatePassword,
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _submitForm,
                child:
                    Text('Cadastrar', style: TextStyle(fontFamily: 'Poppins')),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6BB7E2), // Azul pastel médio
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
