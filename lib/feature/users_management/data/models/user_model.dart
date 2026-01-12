class UserModel {
  final String id;
  final String email;
  final String userName;
  final String fullName;
  final String phoneNumber;
  final List<String> roles;

  UserModel({
    required this.id,
    required this.email,
    required this.userName,
    required this.fullName,
    required this.phoneNumber,
    required this.roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      userName: json['userName']?.toString() ?? '',
      fullName: json['fullName']?.toString() ?? '',
      phoneNumber: json['phoneNumber']?.toString() ?? '',
      roles:
          (json['roles'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'userName': userName,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'roles': roles,
    };
  }

  String getRolesInArabic() {
    return roles
        .map((role) {
          switch (role) {
            case 'Admin':
              return 'مسؤول';
            case 'Account Manager':
              return 'مدير حسابات';
            default:
              return role;
          }
        })
        .join(', ');
  }
}
