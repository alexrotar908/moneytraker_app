import 'package:flutter/material.dart';


// ID Section
class IdSection extends StatelessWidget {
  final String selectedIdType;
  final Function(String?) onIdTypeChanged;
  final TextEditingController idNumberController;

  const IdSection({
    super.key,
    required this.selectedIdType,
    required this.onIdTypeChanged,
    required this.idNumberController,
  });

  String? validateIdNumber(String value, String idType) {
    if (idType == 'DNI') {
      final dniRegex = RegExp(r'^\d{8}[A-Z]$');
      if (!dniRegex.hasMatch(value)) {
        return 'Invalid DNI. Format: 8 digits + 1 letter (e.g. 12345678A)';
      }
    } else if (idType == 'NIE') {
      final nieRegex = RegExp(r'^[XYZ]\d{7}[A-Z]$');
      if (!nieRegex.hasMatch(value)) {
        return 'Invalid NIE. Format: X/Y/Z + 7 digits + 1 letter (e.g. X1234567A)';
      }
    } else if (idType == 'Passport') {
      final passportRegex = RegExp(r'^[A-Z0-9]{9}$');
      if (!passportRegex.hasMatch(value)) {
        return 'Invalid Passport. Format: 9 alphanumeric characters';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: selectedIdType,
          decoration: const InputDecoration(
            labelText: 'Select ID Type',
            border: OutlineInputBorder(),
          ),
          onChanged: onIdTypeChanged,
          items: <String>['DNI', 'NIE', 'Passport']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: idNumberController,
          decoration: InputDecoration(
            labelText: 'Enter your $selectedIdType number',
            border: const OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter an ID number';
            }
            return validateIdNumber(value, selectedIdType);
          },
        ),
      ],
    );
  }
}