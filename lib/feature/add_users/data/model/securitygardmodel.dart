import 'package:hive/hive.dart';


@HiveType(typeId: 0)
class SecurityGuardModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String userName;

  @HiveField(3)
  final String phoneNumber;

  @HiveField(4)
  final String? pictureUrl;

  @HiveField(5)
  final String gateNumber;

  SecurityGuardModel({
    required this.id,
    required this.email,
    required this.userName,
    required this.phoneNumber,
    this.pictureUrl,
    required this.gateNumber,
  });

  factory SecurityGuardModel.fromJson(Map<String, dynamic> json) {
    return SecurityGuardModel(
      id: json['id'],
      email: json['email'],
      userName: json['userName'],
      phoneNumber: json['phoneNumber'],
      pictureUrl: json['pictureUrl'],
      gateNumber: json['gateNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'pictureUrl': pictureUrl,
      'gateNumber': gateNumber,
    };
  }
}
