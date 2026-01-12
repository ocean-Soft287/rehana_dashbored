import 'package:equatable/equatable.dart';

class OwnerModel extends Equatable {
  final int id;
  final String email;
  final String userName;
  final String phoneNumber;
  final String pictureUrl;
  final String villaAddress;
  final String villaNumber;
  final String villaLocation;
  final String villaSpace;
  final String villaStreet;
  final int villaFloorsNumber;

  const OwnerModel({
    required this.id,
    required this.email,
    required this.userName,
    required this.phoneNumber,
    required this.pictureUrl,
    required this.villaAddress,
    required this.villaNumber,
    required this.villaLocation,
    required this.villaSpace,
    required this.villaStreet,
    required this.villaFloorsNumber,
  });

  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    return OwnerModel(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      userName: json['userName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      pictureUrl: json['pictureUrl'] ?? '',
      villaAddress: json['villaAddress'] ?? '',
      villaNumber: json['villaNumber'] ?? '',
      villaLocation: json['villaLocation'] ?? '',
      villaSpace: json['villaSpace'] ?? '',
      villaStreet: json['villaStreet'] ?? '',
      villaFloorsNumber: json['villaFloorsNumber'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'pictureUrl': pictureUrl,
      'villaAddress': villaAddress,
      'villaNumber': villaNumber,
      'villaLocation': villaLocation,
      'villaSpace': villaSpace,
      'villaStreet': villaStreet,
      'villaFloorsNumber': villaFloorsNumber,
    };
  }

  @override

  List<Object?> get props => [
    id,
    email,
    userName,
    phoneNumber,
    pictureUrl,
    villaAddress,
    villaNumber,
    villaLocation,
    villaSpace,
    villaStreet,
    villaFloorsNumber,
  ];
}
