import 'package:flutter/material.dart';
import 'package:money_traker/db_helper/db_helper.dart';
import 'package:money_traker/model/transactions.dart';

class TransactionsProvider extends ChangeNotifier {
  List<Transactions> _transactions = [];

  List<Transactions> get transactions => _transactions;

  double getTotalIncomes() {
    return _transactions
        .where((transaction) => transaction.type == TransactionType.income)
        .map((transaction) => transaction.amount)
        .fold(0, (a, b) => a + b);
  }

  double getTotalExpenses() {
    return _transactions
        .where((transaction) => transaction.type == TransactionType.expense)
        .map((transaction) => transaction.amount)
        .fold(0, (a, b) => a + b);
  }

  double getBalance() {
    return getTotalIncomes() + getTotalExpenses();
  }

  Future<void> loadTransactions() async {
    // Cargar las transacciones desde la base de datos
    _transactions = await DbHelper.transactions();
    notifyListeners();
  }

  Future<void> addTransactions(Transactions transaction) async {
    // Insertar la nueva transacción en la base de datos
    await DbHelper.insert(transaction);
    // Recargar las transacciones para mantener todo sincronizado
    await loadTransactions();
  }

  Future<void> deleteTransaction(int id) async {
    // Eliminar la transacción en la base de datos
    await DbHelper.delete(Transactions(id: id, type: TransactionType.income, amount: 0, description: ''));
    // Recargar las transacciones
    await loadTransactions();
  }

  Future<void> updateTransaction(Transactions transaction) async {
    // Actualizar la transacción en la base de datos
    await DbHelper.update(transaction);
    // Recargar las transacciones
    await loadTransactions();
  }
}
