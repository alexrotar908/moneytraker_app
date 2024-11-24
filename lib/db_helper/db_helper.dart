import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:money_traker/model/transactions.dart';

class DbHelper {

  // Abre o crea la base de datos
  static Future<Database> openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'transactions.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE transactions(id INTEGER PRIMARY KEY, type TEXT, amount DOUBLE, description TEXT)"
        );
      },
      version: 1,
    );
  }

  // Inserta una transacción en la base de datos
  static Future<int> insert(Transactions transaction) async {
    Database database = await openDB();
    return database.insert("transactions", transaction.toMap());
  }

  // Elimina una transacción de la base de datos
  static Future<int> delete(Transactions transaction) async {
    Database database = await openDB();
    return database.delete(
      "transactions", 
      where: "id = ?", 
      whereArgs: [transaction.id],
    );
  }

  // Actualiza una transacción existente en la base de datos
  static Future<int> update(Transactions transaction) async {
    Database database = await openDB();
    return database.update(
      "transactions", 
      transaction.toMap(),
      where: "id = ?", 
      whereArgs: [transaction.id],
    );
  }

  // Recupera todas las transacciones de la base de datos
  static Future<List<Transactions>> transactions() async {
    Database database = await openDB();

    final List<Map<String, dynamic>> transactionsMap = await database.query("transactions");

    return List.generate(transactionsMap.length, (i) {
      return Transactions.fromMap(transactionsMap[i]);
    });
  }
}
