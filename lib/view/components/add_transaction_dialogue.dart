import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_traker/controller/transactions_provider.dart';
import 'package:money_traker/model/transactions.dart';
import 'package:provider/provider.dart';

class AddTransactionDialogue extends StatefulWidget {
  const AddTransactionDialogue({super.key});

  @override
  State<AddTransactionDialogue> createState() => _AddTransactionDialogueState();
}

class _AddTransactionDialogueState extends State<AddTransactionDialogue> {
  int? typeIndex = 0;
  TransactionType type = TransactionType.income;
  double amount = 0;
  String description = '';
  String? descriptionError;

  // Listas de descripciones válidas para ingresos y gastos
  final List<String> validIncomeDescriptions = [
    'salary',
    'bonus',
    'freelance',
    'investment',
    'gift',
    'refund',
  ];

  final List<String> validExpenseDescriptions = [
    'rent',
    'groceries',
    'utilities',
    'transport',
    'entertainment',
    'healthcare',
    'education',
    'subscriptions',
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 600,
      width: double.infinity,
      child: Column(
        children: [
          // Encabezado
          Container(
            height: 6,
            width: 48,
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(3)),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text('New Transaction',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.bold)),
          ),
          // Selector de tipo
          CupertinoSlidingSegmentedControl(
            groupValue: typeIndex,
            children: const {
              0: Text('Income'),
              1: Text('Expense'),
            },
            onValueChanged: (value) {
              setState(() {
                typeIndex = value;
                type = value == 0
                    ? TransactionType.income
                    : TransactionType.expense;
                descriptionError = null; // Reiniciar el error
              });
            },
          ),
          const SizedBox(height: 20),
          // Campo de cantidad
          Text('AMOUNT',
              style: textTheme.bodySmall!.copyWith(color: Colors.teal)),
          TextField(
            inputFormatters: [
              CurrencyTextInputFormatter.currency(symbol: '\$')
            ],
            textAlign: TextAlign.center,
            decoration: const InputDecoration.collapsed(
              hintText: '\$ 0.00',
              hintStyle: TextStyle(color: Colors.grey),
            ),
            keyboardType: TextInputType.number,
            autofocus: true,
            onChanged: (value) {
              final valueWithoutDollarSign = value.replaceAll('\$', '');
              final valueWithoutCommas = valueWithoutDollarSign.replaceAll(',', '');
              if (valueWithoutCommas.isNotEmpty) {
                amount = double.parse(valueWithoutCommas);
              }
            },
          ),
          const SizedBox(height: 20),
          // Campo de descripción
          Text('DESCRIPTION',
              style: textTheme.bodySmall!.copyWith(color: Colors.teal)),
          TextField(
            textAlign: TextAlign.center,
            decoration: const InputDecoration.collapsed(
              hintText: 'Enter a description here',
              hintStyle: TextStyle(color: Colors.grey),
            ),
            keyboardType: TextInputType.text,
            onChanged: (value) {
              setState(() {
                description = value.trim();
                // Validar la descripción en tiempo real según el tipo
                final validDescriptions = type == TransactionType.income
                    ? validIncomeDescriptions
                    : validExpenseDescriptions;

                if (!validDescriptions.contains(description.toLowerCase())) {
                  descriptionError =
                      'Description must be one of: ${validDescriptions.join(", ")}';
                } else {
                  descriptionError = null; // No hay error
                }
              });
            },
          ),
          if (descriptionError != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                descriptionError!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          const SizedBox(height: 20),
          // Botón de agregar transacción
          // Botón de agregar transacción
SizedBox(
  width: 250,
  child: ElevatedButton(
    onPressed: () async {
      if (amount <= 0 || description.isEmpty || descriptionError != null) {
        // Mostrar error si algo no es válido
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid input!')),
        );
        return;
      }

      // Si todo es válido, agregar la transacción
      final transaction = Transactions(
        type: type,
        amount: type == TransactionType.expense ? -amount : amount,
        description: description,
      );

      // Agregar la transacción al proveedor (y a la base de datos)
      await Provider.of<TransactionsProvider>(context, listen: false)
          .addTransactions(transaction);

      // Cerrar el diálogo
      Navigator.pop(context);
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.teal,
    ),
    child: const Text('Add', style: TextStyle(color: Colors.white)),
  ),
),

        ],
      ),
    );
  }
}
