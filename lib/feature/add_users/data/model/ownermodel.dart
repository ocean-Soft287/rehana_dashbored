/// ملف: owner_model.dart
class OwnerModel {
  final String email;
  final String userName;
  final String phoneNumber;
  final String? pictureUrl;
  final String villaAddress;
  final int villaNumber;
  final String villaLocation;
  final String? villaSpace;
  final String villaStreet;
  final int villaFloorsNumber;
  final String token;

  OwnerModel({
    required this.email,
    required this.userName,
    required this.phoneNumber,
    this.pictureUrl,
    required this.villaAddress,
    required this.villaNumber,
    required this.villaLocation,
    this.villaSpace,
    required this.villaStreet,
    required this.villaFloorsNumber,
    required this.token,
  });

  /// factory لإنشاء الموديل من JSON
  factory OwnerModel.fromJson(Map<String, dynamic> json) => OwnerModel(
    email: json['email'] as String,
    userName: json['userName'] as String,
    phoneNumber: json['phoneNumber'] as String,
    pictureUrl: json['pictureUrl'] as String?,
    villaAddress: json['villaAddress'] as String,
    villaNumber: json['VillaNumber'] as int,
    villaLocation: json['villaLocation'] as String,
    villaSpace: json['VillaSpace'] as String?,
    villaStreet: json['villaStreet'] as String,
    villaFloorsNumber: json['villaFloorsNumber'] as int,
    token: json['token'] as String,
  );

  /// لتحويل الموديل إلى JSON
  Map<String, dynamic> toJson() => {
    'email': email,
    'userName': userName,
    'phoneNumber': phoneNumber,
    'pictureUrl': pictureUrl,
    'villaAddress': villaAddress,
    'VillaSpace': villaNumber,
    'villaLocation': villaLocation,
    'VillaNumber': villaSpace,
    'villaStreet': villaStreet,
    'villaFloorsNumber': villaFloorsNumber,
    'token': token,
  };

  /// نسخة معدَّلة (اختيارى)
  OwnerModel copyWith({
    String? email,
    String? userName,
    String? phoneNumber,
    String? pictureUrl,
    String? villaAddress,
    int? villaNumber,
    String? villaLocation,
    String? villaSpace,
    String? villaStreet,
    int? villaFloorsNumber,
    String? token,
  }) => OwnerModel(
    email: email ?? this.email,
    userName: userName ?? this.userName,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    pictureUrl: pictureUrl ?? this.pictureUrl,
    villaAddress: villaAddress ?? this.villaAddress,
    villaNumber: villaNumber ?? this.villaNumber,
    villaLocation: villaLocation ?? this.villaLocation,
    villaSpace: villaSpace ?? this.villaSpace,
    villaStreet: villaStreet ?? this.villaStreet,
    villaFloorsNumber: villaFloorsNumber ?? this.villaFloorsNumber,
    token: token ?? this.token,
  );

  @override
  String toString() =>
      'OwnerModel(email: $email, userName: $userName, '
      'phoneNumber: $phoneNumber, pictureUrl: $pictureUrl, '
      'villaAddress: $villaAddress, villaNumber: $villaNumber, '
      'villaLocation: $villaLocation, villaSpace: $villaSpace, '
      'villaStreet: $villaStreet, villaFloorsNumber: $villaFloorsNumber, '
      'token: $token)';
}
