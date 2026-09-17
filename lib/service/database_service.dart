import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:track_expenses/models/expense_model.dart';

class DatabaseService {
  static late Database db;
  static final String dataBaseName = "expenses.db";
  static Future<void> init() async {
    final cacheDir = await getTemporaryDirectory();
    final path = join(cacheDir.path, dataBaseName);
    db = await openDatabase(path, version: 1, onCreate: _createDB);
  }

  static Future _createDB(Database database, int version) async {
    await database.execute('''
        CREATE TABLE expenses (
        id INTEGER PRIMARY KEY,
        note TEXT,
        value REAL,
        type TEXT,
        image TEXT,
        isIncome INTEGER,
        createdAt TEXT
        )
        ''');
  }

  static Future<void> deleteExpenseFromDB(int id) async {
    await db.delete("expenses", where: "id = ?", whereArgs: [id]);
  }

  static Future<void> closeDB() async => await db.close();
  static Future<void> addExpensesToDB(ExpenseModel expense) async {
    await db.insert("expenses", expense.toJson());
  }

  static Future<List<ExpenseModel>> getExpensesFromDB() async {
    final List<Map<String, dynamic>> maps = await db.query(
      "expenses",
      orderBy: "id DESC",
    );
    return List.generate(maps.length, (i) {
      return ExpenseModel.fromJson(maps[i]);
    });
  }

  static Future<void> clearDB() async {
    await db.delete("expenses");
    final cacheDir = await getTemporaryDirectory();
    if (await cacheDir.exists()) {
      final List<FileSystemEntity> entities = cacheDir.listSync();
      for (var entity in entities) {
        if (entity is File &&
            !entity.path.endsWith('.db') &&
            !entity.path.endsWith('.db-journal')) {
          await entity.delete();
        }
      }
    }
  }
}
