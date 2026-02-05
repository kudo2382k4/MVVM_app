import 'package:mvvm_project/data/dtos/login/login_response_dto.dart';

import '../../dtos/login/login_request_dto.dart';

abstract class IAuthApi {
  Future<LoginResponseDto> login(LoginRequestDto req);

  Future<LoginResponseDto?> getCurrentSession();
  Future<void> logout();

}