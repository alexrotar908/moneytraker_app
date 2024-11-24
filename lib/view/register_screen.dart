import 'package:flutter/material.dart';
import 'package:money_traker/view/components/register_form.dart'; // Import the register form component

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: RegisterForm(), // Use the RegisterForm component
        ),
      ),
    );
  }
}
