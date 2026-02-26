import 'package:mvvm_project/data/implementations/api/auth_api.dart';
import 'package:mvvm_project/data/implementations/local/app_database.dart';
import 'package:mvvm_project/data/implementations/repositories/managed_user_repository.dart';
import 'package:mvvm_project/viewmodels/login/login_viewmodel.dart';
import 'package:mvvm_project/viewmodels/usermanagement/user_viewmodel.dart';

import 'data/implementations/api/managed_user_api.dart';
import 'data/implementations/mapper/auth_mapper.dart';
import 'data/implementations/mapper/managed_user_mapper.dart';
import 'data/implementations/repositories/auth_repository.dart';

LoginViewmodel buildLoginVM(){
  final api = AuthApi(AppDatabase.instance);                  /// implements auth api
  final mapper = AuthSessionMapper();     /// DTO -> entity
  final repo = AuthRepository(api, mapper);    /// implements auth repo
  return LoginViewmodel(repo);

}

ManagedUserRepository buildManagedUserRepository(){
  final api = ManagedUserApi(AppDatabase.instance);
  final mapper = ManagedUserMapper();
  return ManagedUserRepository(api: api, mapper: mapper);
}

UserViewmodel buildUsersViewModel(){
  final repo = buildManagedUserRepository();
  return UserViewmodel(repo: repo);
}