import 'package:dartz/dartz.dart';
import '../../../../core/utils/Failure/failure.dart';
import '../models/add_user_request_model.dart';
import '../models/user_model.dart';

abstract class UsersManagementRepo {
  Future<Either<Failure, String>> addUser(AddUserRequestModel request);
  Future<Either<Failure, List<UserModel>>> getAllUsers();
}
