import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

class DbHelper {
  static Database? _db;

  static const String DB_Name = 'test.db';
  static const String Table_User = 'user';
  static const int Version = 1;

  static const String C_Username = 'user_name';
  static const String C_Email = 'email';
  static const String C_Password = 'password';

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }

    _db = await initDb();

    return _db!;
  }
}

Future<Database> initDb() async {
  io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = join(documentsDirectory.path, DbHelper.DB_Name);
  var db =
      await openDatabase(path, version: DbHelper.Version, onCreate: _onCreate);
  return db;
}

void _onCreate(Database db, int version) async {
  await db.execute("CREATE TABLE ${DbHelper.Table_User} ("
      "${DbHelper.C_Username} TEXT PRIMARY KEY,"
      "${DbHelper.C_Email} TEXT,"
      "${DbHelper.C_Password} TEXT"
      ")");
}
