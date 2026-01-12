enum UserRole {
  admin('Admin', 'مسؤول'),
  accountManager('Account Manager', 'مدير حسابات');

  final String englishName;
  final String arabicName;

  const UserRole(this.englishName, this.arabicName);

  static UserRole fromEnglish(String name) {
    return UserRole.values.firstWhere(
      (role) => role.englishName == name,
      orElse: () => UserRole.accountManager,
    );
  }

  static UserRole fromArabic(String name) {
    return UserRole.values.firstWhere(
      (role) => role.arabicName == name,
      orElse: () => UserRole.accountManager,
    );
  }
}

class AddUserRequestModel {
  final String email;
  final String password;
  final String fullName;
  final String phoneNumber;
  final List<String> roles;

  AddUserRequestModel({
    required this.email,
    required this.password,
    required this.fullName,
    required this.phoneNumber,
    required this.roles,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'roles': roles,
    };
  }
}
