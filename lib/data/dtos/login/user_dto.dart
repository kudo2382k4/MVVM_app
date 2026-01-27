class UserDto {
  final String id;
  final String userName;

  const UserDto({required this.id, required this.userName});

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: (json['id'] ?? '').toString(),
      userName: (json['userName'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userName': userName
  };
}
