import 'package:dartz/dartz.dart';
import '../../../../core/utils/Failure/failure.dart';
import '../model/login_model.dart';
abstract class LoginRepo {
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> forgetpassword({
    required String email,
  });

  Future<Either<Failure, String>> resetpassword({
    required String email,
    required String token,
    required String newpassword,
  });
}