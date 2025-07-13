import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rehana_dashboared/core/utils/Failure/failure.dart';
import 'package:rehana_dashboared/feature/add_users/data/model/securitygardmodel.dart';

abstract class Securityrepo{

  Future<Either<Failure, List<SecurityGuardModel>>> getSecurityData();
  Future<Either<Failure, String>> deleteSecurity(int id);
  Future<Either<Failure,SecurityGuardModel>>updatesecurity(
      {
        required String id,
        required String password,


        String name,
        String email,
        String phoneNumber,
        MultipartFile? image,
        String gateNumber,

      });
}