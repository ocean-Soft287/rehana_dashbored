import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rehana_dashboared/core/utils/Failure/failure.dart';
import 'package:rehana_dashboared/core/utils/api/dio_consumer.dart';
import 'package:rehana_dashboared/feature/Auth/data/model/login_model.dart';
import 'package:rehana_dashboared/feature/UserManagement/data/usermangmentrepo.dart';
import '../../../../core/utils/api/endpoint.dart';
import 'model/owner_model.dart';

class Usermangmentrepoimp implements UserMangmentRepo{
  final DioConsumer dioConsumer;

  Usermangmentrepoimp({required this.dioConsumer});
  @override
  Future<Either<Failure, UserModel>> addOwner({
    required String email,
    required String password,
    required String fullName,
    required String phonenumber,
    required String role,
  }) async{
    try {
      final response = await dioConsumer.post(
        EndPoint.addOwner,
        data: {
          "email": email,
          "password": password,
          "fullName": fullName,
          "phoneNumber": phonenumber,
          "roles": [
            role
          ]
        },
      );

      final json = response as Map<String, dynamic>;
      final model = UserModel.fromJson(json);






      return right(model);
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(ServerFailure("Login failed: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getAllOwners() async{
    try {
      final rawList = await dioConsumer.get(EndPoint.getowner)
      as List<dynamic>;

      final usermodel = rawList
          .map((json) =>
          UserModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return right(usermodel);
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
  Failure _handleDioError(DioException error) {
    final data = error.response?.data;

    if (data is Map<String, dynamic>) {
      final message = data['description'] ?? data['message'] ?? 'Unknown error';
      return ServerFailure(message.toString());
    } else if (data is List) {
      final firstError = data.isNotEmpty && data.first is Map<String, dynamic>
          ? data.first['description']
          : 'Unknown list error';
      return ServerFailure(firstError.toString());
    } else {
      return ServerFailure(error.message ?? "Unknown Dio error");
    }
  }


  @override
  Future<Either<Failure, List<OwnerModel>>> getAllMembers() async{
    try {
      final rawList = await dioConsumer.get(EndPoint.getAllMembers)
      as List<dynamic>;

      final usermodel = rawList
          .map((json) =>
          OwnerModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return right(usermodel);
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }


}