import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rehana_dashboared/core/utils/Failure/failure.dart';
import 'package:rehana_dashboared/core/utils/api/dio_consumer.dart';
import 'package:rehana_dashboared/feature/add_users/data/model/securitygardmodel.dart';
import 'package:rehana_dashboared/feature/security_view/data/repo/security_repo.dart';

import '../../../../core/utils/api/endpoint.dart';
class SecurityRepoImp implements Securityrepo {
  final DioConsumer dioConsumer;
  SecurityRepoImp({required this.dioConsumer});

  @override
  Future<Either<Failure, List<SecurityGuardModel>>> getSecurityData() async {
    try {
      final rawList = await dioConsumer.get(EndPoint.allsecrity)
      as List<dynamic>;

      final guards = rawList
          .map((json) =>
          SecurityGuardModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return right(guards);
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  Failure _handleDioError(DioException error) =>
      ServerFailure(error.message ?? "Unknown error occurred");

  @override
  Future<Either<Failure, String>> deleteSecurity(int id) async {
    try {
      final response = await dioConsumer.delete("${EndPoint.deleteSecurityGuard}$id");
      if (response == "SecurityGuard Deleted Successfully") {
        return Right(response);
      } else {
        return Left(ServerFailure("Unexpected response: $response"));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }


  @override
  Future<Either<Failure, SecurityGuardModel>> updatesecurity({
    required String id,
    required String password,
    String? name,
    String? email,
    String? phoneNumber,
    MultipartFile? image,
    String? gateNumber,
  }) async {
    try {
      final formData = FormData.fromMap({
        'id': id,
        'password': password,
        if (name != null) 'UserName': name,
        if (email != null) 'email': email,
        if (phoneNumber != null) 'phoneNumber': phoneNumber,
        if (image != null) 'image': image,
        if (gateNumber != null) 'gateNumber': gateNumber,
      });

      final response = await dioConsumer.put(
        EndPoint.updatesecrity,
        data: formData,
      );

      final updatedGuard = SecurityGuardModel.fromJson(response as Map<String, dynamic>);
      return Right(updatedGuard);

    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }



}
