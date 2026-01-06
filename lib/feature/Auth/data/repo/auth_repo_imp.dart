import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rehana_dashboared/feature/Auth/data/repo/auth_repo.dart';

import '../../../../core/utils/Failure/failure.dart';
import '../../../../core/utils/Network/local/cache_manager.dart';
import '../../../../core/utils/api/dio_consumer.dart';
import '../../../../core/utils/api/endpoint.dart';
import '../model/login_model.dart';


class Loginrepoimp implements LoginRepo {
  final DioConsumer dioConsumer;

  Loginrepoimp({required this.dioConsumer});

  @override
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dioConsumer.post(
        EndPoint.login,
        data: {'email': email, 'password': password, 'rememberMe': true},
      );

      final json = response as Map<String, dynamic>;
      final model = UserModel.fromJson(json);

      // ✅ تأكيد التوكن
      if (model.token.isEmpty) {
        return left(ServerFailure("Missing token in response"));
      }

      // ✅ حفظ التوكن
      await CacheManager.saveAccessToken(model.token);
      await CacheManager().saveData(key: "name", value: model.userName);

      // ✅ حفظ الدور (بأمان)
      final role =
      model.roles.isNotEmpty ? model.roles.first : 'user';

      await CacheManager().saveData(
        key: 'role',
        value: role,
      );

      // (اختياري للتأكد)
      final savedToken = await CacheManager.getAccessToken();
      final savedRole = CacheManager().getData(key: 'role');

      print('Saved Token => $savedToken');
      print('Saved Role  => $savedRole');

      return right(model);
    } on DioException catch (e, stackTrace) {
      print("Dio error: $e");
      print("StackTrace: $stackTrace");
      return left(_handleDioError(e));
    } catch (e, stackTrace) {
      print("Unexpected error: $e");
      print("StackTrace: $stackTrace");
      return left(
        ServerFailure("Login failed: ${e.toString()}"),
      );
    }
  }

  Failure _handleDioError(DioException error) {
    return ServerFailure(
      error.message ?? "Unknown error occurred",
    );
  }







  @override
  Future<Either<Failure, String>> forgetpassword({
    required String email,
  }) async {
    try {
      final response = await dioConsumer.post(
        EndPoint.forgetpassw,
        data: {'email': email},
      );

      // طالما السيرفر بيرجع String صريح
      final responseMessage = response.toString();

      if (responseMessage.trim() == "Email is Not Exist") {
        return left(ServerFailure("This email is not registered."));
      }

      return right(responseMessage);
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(ServerFailure("Forget password failed: ${e.toString()}"));
    }
  }




  @override
  Future<Either<Failure, String>> resetpassword({
    required String email,
    required String token,
    required String newpassword,
  }) async {
    final data = {'email': email, 'token': token, 'newPassword': newpassword};

    try {
      final response = await dioConsumer.post(
        EndPoint.changePassconfirm,
        data: jsonEncode(data),
      );

      final responseMessage = response.toString();

      if (responseMessage.trim() == "Invalid or Expired Token") {
        return left(ServerFailure("TInvalid or Expired Token."));
      }

      return right(responseMessage);
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(ServerFailure("Reset password failed: ${e.toString()}"));
    }
  }

  // Failure _handleDioError(DioException error) {
  //   return ServerFailure(error.message ?? "Unknown error occurred");
  // }
}