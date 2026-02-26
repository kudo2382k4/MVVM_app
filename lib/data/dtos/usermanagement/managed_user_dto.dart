class ManagedUserDto {
  final int id;
  final String fullName;
  final String dob;
  final String address;
  final String createdAt;

  const ManagedUserDto({
    required this.id,
    required this.fullName,
    required this.dob,
    required this.address,
    required this.createdAt,
  });

  factory ManagedUserDto.fromMap(Map<String, dynamic> map) {
    return ManagedUserDto(
      id: map['id'] as int,
      fullName: map['full_name'] as String,
      dob: map['dob'] as String,
      address: map['address'] as String,
      createdAt: map['created_at'] as String,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'full_name': fullName,
    'dob': dob,
    'address': address,
    'created_at': createdAt,
  };
}

