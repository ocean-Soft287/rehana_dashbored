import 'package:dartz/dartz.dart';

import '../../../core/utils/Failure/failure.dart';
import 'model/owner_model.dart';
import '../../Auth/data/model/login_model.dart';

abstract class UserMangmentRepo{
  Future<Either<Failure, UserModel>> addOwner({
    required String email,
    required String password,
    required String fullName,
    required String phonenumber,
    required String role,
  });
  Future<Either<Failure, List<UserModel>>>getAllOwners();
  Future<Either<Failure, List<OwnerModel>>>getAllMembers();

  Future<Either<Failure, void>> updateOwner({
    required int id,
    required String email,
    required String name,
    required String phoneNumber,
    required String password,
    required String villaAddress,
    required int villaNumber,
    required String villaLocation,
    required String villaSpace,
    required String villaStreet,
    required int villaFloorsNumber,
    dynamic image,
  });

  Future<Either<Failure, void>> deleteOwner(int id);
}