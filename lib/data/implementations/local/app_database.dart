import 'package:mvvm_project/data/implementations/local/password_hasher.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();
  static final AppDatabase instance = AppDatabase._();
  // factory AppDatabase() => instance;

  Database? _db;

  Future<Database> get db async {
    _db ??= await _open();
    return _db!;
  }

  Future<Database> _open() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'mvvm_project.db');

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        //user: luu username + password_hash
        await db.execute('''
          CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_name TEXT NOT NULL UNIQUE,
            password_hash TEXT NOT NULL
         );
            ''');
        // session: chi luu 1 session dang dang nhap (id =1)
        await db.execute('''
          CREATE TABLE session(
            id INTEGER PRIMARY KEY CHECK (id = 1),
            user_id INTEGER NOT NULL,
            token TEXT NOT NULL,
            created_at TEXT NOT NULL
          );
        ''');
        await db.insert('users', {
          'user_name': 'admin',
          'password_hash': PasswordHasher.sha256Hash('Fu@2026'),
        });
      },
    );
  }
}
