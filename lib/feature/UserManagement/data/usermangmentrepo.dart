import 'package:dartz/dartz.dart';

import '../../../core/utils/Failure/failure.dart';
import '../../Auth/data/model/login_model.dart';

abstract class UserMangmentRepo{
  Future<Either<Failure, UserModel>> addOwner({
    required String email,
    required String password,
    required String fullName,
    required String phonenumber,
    required String role,
  });
  Future<Either<Failure, List<UserModel>>>getallowner();
}