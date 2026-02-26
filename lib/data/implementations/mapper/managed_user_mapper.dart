import 'package:mvvm_project/data/interfaces/mapper/imapper.dart';

import '../../../domain/entities/managed_user.dart';
import '../../dtos/usermanagement/managed_user_dto.dart';

class ManagedUserMapper implements IMapper<ManagedUserDto, ManagedUser>{
  @override
  ManagedUser map(ManagedUserDto input){
    return ManagedUser(
      id: input.id,
      fullName: input.fullName,
      dob: input.dob,
      address: input.address,
      createdAt: input.createdAt,
    );
  }
}