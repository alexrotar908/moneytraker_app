import 'package:flutter/material.dart';
import 'package:money_traker/controller/transactions_provider.dart';
import 'package:money_traker/model/transactions.dart';
import 'package:provider/provider.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: FutureBuilder<void>(
          // Cargar las transacciones desde la base de datos al iniciar
          future: Provider.of<TransactionsProvider>(context, listen: false)
              .loadTransactions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error loading transactions!',
                  style: TextStyle(color: Colors.red.shade700),
                ),
              );
            }

            // Obtener las transacciones del provider
            final transactions =
                Provider.of<TransactionsProvider>(context).transactions;

            if (transactions.isEmpty) {
              return const Center(
                child: Text('No transactions found'),
              );
            }

            return ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                final type = transaction.type == TransactionType.income
                    ? 'Income'
                    : 'Expense';
                final value = transaction.type == TransactionType.expense
                    ? '-\$ ${transaction.amount.abs().toStringAsFixed(2)}'
                    : '\$ ${transaction.amount.abs().toStringAsFixed(2)}';
                final color = transaction.type == TransactionType.expense
                    ? Colors.red
                    : Colors.teal;

                return ListTile(
                  title: Text(transaction.description),
                  subtitle: Text(type),
                  trailing: Text(
                    value,
                    style: TextStyle(fontSize: 14, color: color),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
