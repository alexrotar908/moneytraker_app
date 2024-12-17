import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:money_traker/model/transactions.dart';

class DbHelper {

  // Abre o crea la base de datos
  static Future<Database> openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'transactions.db'),
      onCreate: (db, version) async{
        await db.execute(
          "CREATE TABLE transactions(id INTEGER PRIMARY KEY, type TEXT, amount DOUBLE, description TEXT)"
        );

        await db.execute(
          '''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            id_type TEXT NOT NULL,
            id_number TEXT NOT NULL UNIQUE,
            first_name TEXT NOT NULL,
            last_name TEXT NOT NULL,
            username TEXT NOT NULL UNIQUE,
            pin TEXT NOT NULL
          )
          '''
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

  // Inserta un usuario en la base de datos
  static Future<int> insertUser(Map<String, dynamic> userData) async {
    Database database = await openDB();
    try {
      return await database.insert("users", userData);
    } catch (e) {
      throw Exception("Error al registrar el usuario: ${e.toString()}");
    }
  }

  // Verifica si un usuario existe al iniciar sesión
  static Future<bool> validateUser(String username, String pin) async {
    Database database = await openDB();
    final result = await database.query(
      "users",
      where: "username = ? AND pin = ?",
      whereArgs: [username, pin],
    );
    return result.isNotEmpty;
  }

  // Verifica si hay al menos un usuario registrado
  static Future<bool> hasRegisteredUsers() async {
    Database database = await openDB();
    final result = await database.query("users");
    return result.isNotEmpty;
  }
}
