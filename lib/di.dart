import 'package:mvvm_project/data/implementations/api/auth_api.dart';
import 'package:mvvm_project/data/implementations/local/app_database.dart';
import 'package:mvvm_project/viewmodels/login/login_viewmodel.dart';

import 'data/implementations/mapper/auth_mapper.dart';
import 'data/implementations/repositories/auth_repository.dart';

LoginViewmodel buildLoginVM(){
  final api = AuthApi(AppDatabase.instance);                  /// implements auth api
  final mapper = AuthSessionMapper();     /// DTO -> entity
  final repo = AuthRepository(api, mapper);    /// implements auth repo
  return LoginViewmodel(repo);

}