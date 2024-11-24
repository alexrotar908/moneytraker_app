import 'package:flutter/material.dart';
import 'package:money_traker/view/home_screen.dart';
import 'package:money_traker/view/register_data/user_section.dart';
import 'package:money_traker/view/register_screen.dart'; // Necesario para el InputFormatter
 // Asegúrate de importar la clase que creaste

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>(); // Clave para el formulario
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Asignamos la clave del formulario
          child: Column(
            children: [
              UserSection(
                usernameController: _usernameController,
                pinController: _pinController,
              ),
              const SizedBox(height: 24),

              // Botón de login
              ElevatedButton(
                onPressed: () {
                  // Validamos el formulario
                  if (_formKey.currentState?.validate() ?? false) {
                    // Si el formulario es válido, redirigimos al HomeScreen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  }
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 16),

              // Enlace para ir a la pantalla de registro
              TextButton(
                onPressed: () {
                  // Aquí se navegaría al RegisterScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Don\'t have an account? Register here',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
