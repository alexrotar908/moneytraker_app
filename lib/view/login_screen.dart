import 'package:flutter/material.dart';
import 'package:money_traker/view/components/login_form.dart'; // Importa el componente de login

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: LoginForm(), // Usa el componente LoginForm
        ),
      ),
    );
  }
}
