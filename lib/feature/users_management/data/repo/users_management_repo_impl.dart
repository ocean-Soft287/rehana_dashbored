import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/utils/Failure/failure.dart';
import '../../../../core/utils/api/dio_consumer.dart';
import '../../../../core/utils/api/endpoint.dart';
import '../models/add_user_request_model.dart';
import '../models/user_model.dart';
import 'users_management_repo.dart';

class UsersManagementRepoImpl implements UsersManagementRepo {
  final DioConsumer dioConsumer;

  UsersManagementRepoImpl({required this.dioConsumer});

  @override
  Future<Either<Failure, String>> addUser(AddUserRequestModel request) async {
    try {
      final response = await dioConsumer.post(
        EndPoint.addOwner,
        data: request.toJson(),
      );

      return right(response.toString());
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(ServerFailure("خطأ في إضافة المستخدم: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getAllUsers() async {
    try {
      final response = await dioConsumer.get(EndPoint.getowner);

      if (response is List) {
        final users =
            response
                .map((item) => UserModel.fromJson(item as Map<String, dynamic>))
                .toList();
        return right(users);
      }

      return left(ServerFailure("صيغة الاستجابة غير صحيحة"));
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(ServerFailure("خطأ في تحميل المستخدمين: ${e.toString()}"));
    }
  }

  Failure _handleDioError(DioException error) {
    if (error.response != null) {
      final statusCode = error.response!.statusCode;
      switch (statusCode) {
        case 400:
          return ServerFailure("بيانات غير صحيحة");
        case 401:
          return ServerFailure("غير مصرح لك بهذه العملية");
        case 404:
          return ServerFailure("الخدمة غير موجودة");
        case 500:
          return ServerFailure("خطأ في السيرفر");
        default:
          return ServerFailure(
            error.response!.data?.toString() ?? "خطأ غير معروف",
          );
      }
    }
    return ServerFailure(error.message ?? "خطأ غير معروف");
  }
}
