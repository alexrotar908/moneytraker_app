import 'package:flutter/material.dart';
import 'package:money_traker/controller/transactions_provider.dart';
import 'package:money_traker/view/widgets/header_card.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return FutureBuilder<void>(
      // Cargar transacciones desde la base de datos al iniciar
      future: Provider.of<TransactionsProvider>(context, listen: false)
          .loadTransactions(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error loading data!',
              style: TextStyle(color: Colors.red.shade700),
            ),
          );
        }

        // Obtener valores actualizados del provider
        final provider = Provider.of<TransactionsProvider>(context);
        final balance = provider.getBalance();
        final incomes = provider.getTotalIncomes();
        final expenses = provider.getTotalExpenses();

        return SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 12),
              Text(
                'MONEY TRACKER',
                style: textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade900,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Balance',
                style: textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              Text(
                '\$ ${balance.toStringAsFixed(2)}',
                style: textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    HeaderCard(
                      title: 'Incomes',
                      amount: incomes,
                      icon: const Icon(Icons.attach_money, color: Colors.teal),
                    ),
                    const SizedBox(width: 12),
                    HeaderCard(
                      title: 'Expenses',
                      amount: expenses,
                      icon: const Icon(Icons.attach_money, color: Colors.red),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
