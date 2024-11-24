import 'package:flutter/material.dart';
import 'package:money_traker/view/components/add_transaction_dialogue.dart';
import 'package:money_traker/view/components/home_header.dart';
import 'package:money_traker/view/components/transactions_list.dart';
import 'package:money_traker/view/login_screen.dart';
import 'package:money_traker/controller/transactions_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
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

            return Column(
              children: const [
                HomeHeader(),
                TransactionsList(),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          // Mostrar el diálogo para agregar una transacción
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return const AddTransactionDialogue();
            },
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
