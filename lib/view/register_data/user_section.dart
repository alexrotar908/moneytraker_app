import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserSection extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController pinController;

  const UserSection({
    super.key,
    required this.usernameController,
    required this.pinController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: usernameController,
          decoration: const InputDecoration(
            labelText: 'Username',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a username';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: pinController,
          decoration: const InputDecoration(
            labelText: 'PIN',
            border: OutlineInputBorder(),
          ),
          obscureText: true,
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(4),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a PIN';
            } else if (value.length != 4) {
              return 'PIN must be 4 digits';
            }
            return null;
          },
        ),
      ],
    );
  }
}