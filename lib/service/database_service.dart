import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:track_expenses/models/expense_model.dart';

class DatabaseService {
  static late Database db;
  static final String dataBaseName = "expenses.db";

  static Future<void> init(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
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
  }
}
