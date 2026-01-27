import 'package:mvvm_project/data/interfaces/api/iauth_api.dart';

import '../../dtos/login/login_request_dto.dart';
import '../../dtos/login/login_response_dto.dart';

class AuthApi implements IAuthApi {
  @override
  Future<LoginResponseDto> login(LoginRequestDto req) async {
    await Future.delayed(const Duration(milliseconds: 600));

    if (req.userName == 'admin' && req.password == 'admin') {
      final json = {
        'token': 'fake_jwt_abc123',
        'user': {'id': '1', 'userName': 'admin'},
      };
      return LoginResponseDto.fromJson(json);
    } else {
      throw Exception('Invalid username or password');
    }
  }
}
