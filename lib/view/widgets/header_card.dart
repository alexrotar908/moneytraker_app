import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HeaderCard extends StatelessWidget {
  final String title;
  final double amount;
  final Widget icon;
  
  const HeaderCard({
    super.key, 
    required this.title, 
    required this.amount, 
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Formatear el monto usando el package intl para agregar comas
    final NumberFormat currencyFormatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
    final formattedAmount = currencyFormatter.format(amount.abs());

    // Determinar el color basado en si es un ingreso o gasto
    final color = amount < 0 ? Colors.red : Colors.teal;

    return Expanded(
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  const SizedBox(width: 4),
                  Text(
                    title, 
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                formattedAmount, 
                style: textTheme.titleLarge!.copyWith(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
