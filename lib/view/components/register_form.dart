import 'package:flutter/material.dart';
import 'package:money_traker/view/login_screen.dart';
import 'package:money_traker/view/register_data/id_section.dart';
import 'package:money_traker/view/register_data/name_section.dart';
import 'package:money_traker/view/register_data/user_section.dart'; // Necessary for InputFormatter

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _idNumberController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  String selectedIdType = 'DNI';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              IdSection(
                selectedIdType: selectedIdType,
                onIdTypeChanged: (newValue) {
                  setState(() {
                    selectedIdType = newValue!;
                  });
                },
                idNumberController: _idNumberController,
              ),
              const SizedBox(height: 24),
              NameSection(
                firstNameController: _firstNameController,
                lastNameController: _lastNameController,
              ),
              const SizedBox(height: 24),
              UserSection(
                usernameController: _usernameController,
                pinController: _pinController,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Registering...')),
                    );
                  }
                },
                child: const Text('Register'),
              ),
              const SizedBox(height: 16),
              // Link to go to LoginScreen
          TextButton(
            onPressed: () {
              // Navigate to LoginScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            child: const Text(
              'Already have an account? Log in here',
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
