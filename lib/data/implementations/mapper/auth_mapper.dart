import 'package:mvvm_project/domain/entities/auth_session.dart';

import '../../../domain/entities/user.dart';
import '../../dtos/login/login_response_dto.dart';
import '../../interfaces/mapper/imapper.dart';

class AuthSessionMapper implements IMapper<LoginResponseDto, AuthSession> {
  @override
  AuthSession map(LoginResponseDto input){
    return AuthSession(
      token: input.token,
      user: User(
        id: input.user.id,
        userName: input.user.userName,
      ),
    );
  }
}