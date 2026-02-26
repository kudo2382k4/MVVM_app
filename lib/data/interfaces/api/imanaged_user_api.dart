import '../../dtos/usermanagement/managed_user_dto.dart';
import '../../dtos/usermanagement/update_insert_user_request_dto.dart';

abstract class IManagedUserApi {
  Future<List<ManagedUserDto>> getAll();
  Future<ManagedUserDto?> getById(int id);
  Future<int> create(UpdateInsertUserRequestDto req);
  Future<int> update(int id, UpdateInsertUserRequestDto req);
  Future<void> delete(int id);

  Future<void> seedDemoIfEmpty();
}