import 'package:mvvm_project/data/implementations/local/password_hasher.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();
  static final AppDatabase instance = AppDatabase._();

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
      version: 3,
      onCreate: (db, version) async {
        // Bảng users: lưu username + password_hash
        await db.execute('''
          CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_name TEXT NOT NULL UNIQUE,
            password_hash TEXT NOT NULL
          );
        ''');

        // Bảng session: chỉ lưu 1 session đang đăng nhập (id = 1)
        await db.execute('''
          CREATE TABLE IF NOT EXISTS session (
            id INTEGER PRIMARY KEY CHECK (id = 1),
            user_id INTEGER NOT NULL,
            token TEXT NOT NULL,
            created_at TEXT NOT NULL
          );
        ''');

        // Bảng managed_users: quản lý danh sách người dùng
        await db.execute('''
          CREATE TABLE IF NOT EXISTS managed_users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            full_name TEXT NOT NULL,
            dob TEXT NOT NULL,
            address TEXT NOT NULL,
            created_at TEXT NOT NULL
          );
        ''');

        // Seed tài khoản admin mặc định
        await db.insert('users', {
          'user_name': 'admin',
          'password_hash': PasswordHasher.sha256Hash('Fu@2026'),
        });
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // Cover cả DB version 1 và version 2 bị lỗi (không có managed_users)
        if (oldVersion <= 2) {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS managed_users (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              full_name TEXT NOT NULL,
              dob TEXT NOT NULL,
              address TEXT NOT NULL,
              created_at TEXT NOT NULL
            );
          ''');
        }
      },
    );
  }
}
