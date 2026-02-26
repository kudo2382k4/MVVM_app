import 'package:mvvm_project/data/implementations/local/app_database.dart';
import 'package:mvvm_project/data/interfaces/api/imanaged_user_api.dart';
import 'package:sqflite/sqflite.dart';

import '../../dtos/usermanagement/managed_user_dto.dart';
import '../../dtos/usermanagement/update_insert_user_request_dto.dart';

class ManagedUserApi implements IManagedUserApi {
  final AppDatabase database;
  ManagedUserApi(this.database);

  @override
  Future<List<ManagedUserDto>> getAll() async {
    final db = await database.db;
    final result = await db.query(
      'managed_users',
      orderBy: 'id DESC',
    );
    return result.map((e) => ManagedUserDto.fromMap(e)).toList();
  }

  @override
  Future<ManagedUserDto?> getById(int id) async {
    final db = await database.db;
    final rows = await db.query(
      'managed_users',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return ManagedUserDto.fromMap(rows.first);
  }

  @override
  Future<int> create(UpdateInsertUserRequestDto req) async {
    final db = await database.db;
    return db.insert('managed_users', req.toMapForInsert());
  }

  @override
  Future<int> update(int id, UpdateInsertUserRequestDto req) async {
    final db = await database.db;
    return db.update(
      'managed_users',
      req.toMapForUpdate(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> delete(int id) async {
    final db = await database.db;
    await db.delete(
      'managed_users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> seedDemoIfEmpty() async {
    final db = await database.db;
    final count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM managed_users'),
    );

    if((count ?? 0) > 0) return;

    await db.insert('managed_users',{
      'full_name': 'Đỗ Trung Hiếu',
      'dob': '23/08/2004',
      'address': '17 Thái Bình',
      'created_at': DateTime.now().toIso8601String(),
    });

    await db.insert('managed_users',{
      'full_name': 'Nguyễn Nghiêm Khánh Tiệp',
      'dob': '01/10/2004',
      'address': '37 Nghệ An',
      'created_at': DateTime.now().toIso8601String(),
    });


  }
}