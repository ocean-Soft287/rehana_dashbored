import 'package:dartz/dartz.dart';
import 'package:rehana_dashboared/feature/add_users/data/model/person_model.dart';

import '../../../../core/utils/Failure/failure.dart';
import '../model/ownermodel.dart';

import 'package:dio/dio.dart';

import '../model/securitygardmodel.dart';

abstract class Adduserrepo {
  Future<Either<Failure, OwnerModel>> addOwner({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required MultipartFile? image,
    required String villaAddress,
    required String villaLocation,
    required String villaNumber,
    required String villaSpace,
    required String villaStreet,
    required int villaFloorsNumber,
  });
  Future<Either<Failure, SecurityGuardModel>> addsecurity({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required MultipartFile? image,
    required String gateNumber,
  });
  Future<Either<Failure, Person>> adduserperson({
    required String fullName,
    required String phoneNumber,
    required bool isMarried,
    required String address,
    required String date,
    required int villaNumber,
  });
}
