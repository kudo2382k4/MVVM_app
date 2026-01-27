import 'package:mvvm_project/data/interfaces/mapper/imapper.dart';
import 'package:mvvm_project/data/interfaces/repositories/iauth_repository.dart';

import '../../../domain/entities/auth_session.dart';
import '../../dtos/login/login_request_dto.dart';
import '../../dtos/login/login_response_dto.dart';
import '../api/auth_api.dart';

class AuthRepository implements IAuthRepository{
  final AuthApi _authApi;
  final IMapper<LoginResponseDto, AuthSession> _authSessionMapper;

  AuthRepository(this._authApi, this._authSessionMapper);

  @override
  Future<AuthSession> login(String userName, String password) async {
    final req = LoginRequestDto(userName: userName, password: password);
    final dto = await _authApi.login(req);      ///DTO response
    return _authSessionMapper.map(dto);         /// DTO -> Entity
  }

}