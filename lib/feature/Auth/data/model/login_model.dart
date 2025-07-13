class UserModel {
  final String email;
  final String userName;
  final String fullName;
  final String? phoneNumber;      // Nullable
  final List<String> roles;
  final String token;

  UserModel({
    required this.email,
    required this.userName,
    required this.fullName,
    this.phoneNumber,
    required this.roles,
    required this.token,
  });

  // fromJson: يحوّل Map جاية من الـ API لكائن UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? '',
      userName: json['userName'] ?? '',
      fullName: json['fullName'] ?? '',
      phoneNumber: json['phoneNumber'],
      roles: List<String>.from(json['roles'] ?? []),
      token: json['token'] ?? '',
    );
  }

  // toJson: يرجّع Map تقدر تبعتها للـ API أو تخزنها محليًّا
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'userName': userName,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'roles': roles,
      'token': token,
    };
  }
}
