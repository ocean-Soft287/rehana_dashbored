import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rehana_dashboared/core/utils/Failure/failure.dart';
import 'package:rehana_dashboared/core/utils/api/dio_consumer.dart';
import 'package:rehana_dashboared/core/utils/api/endpoint.dart';
import 'package:rehana_dashboared/feature/add_users/data/model/ownermodel.dart';
import 'package:rehana_dashboared/feature/add_users/data/model/person_model.dart';
import 'package:rehana_dashboared/feature/add_users/data/model/securitygardmodel.dart';
import 'package:rehana_dashboared/feature/add_users/data/repo/adduserrepo.dart';

class AddUserRepoImpl implements Adduserrepo {
  final DioConsumer dioConsumer;
  AddUserRepoImpl({required this.dioConsumer});

  @override
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
  }) async {
    try {
      final form = FormData.fromMap({
        'name': name,
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
        'villaAddress': villaAddress,
        'villaLocation': villaLocation,
        'VillaNumber': villaNumber,
        'VillaSpace': villaSpace,
        'villaStreet': villaStreet,
        'villaFloorsNumber': villaFloorsNumber,
        if (image != null) 'Image': image, // غيّر اسم الحقل لو الـ API مختلف
      });

      final res = await dioConsumer.post(
        EndPoint.addmember,
        data: form,
        options: Options(contentType: 'multipart/form-data'),
      );

      final dynamic raw = res is Response ? res.data : res;
      final ownerJson = raw['data'] ?? raw;

      return Right(
        OwnerModel.fromJson(Map<String, dynamic>.from(ownerJson as Map)),
      );
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Person>> adduserperson({
    required String fullName,
    required String phoneNumber,
    required bool isMarried,
    required String address,
    required String date, // هنا غيّر النوع لـ String
    required int villaNumber,
  }) async {
    try {
      final res = await dioConsumer.post(
        EndPoint.createMemberAccount,
        data: {
          "fullName": fullName,
          "phoneNumber": phoneNumber,
          "isMarried": isMarried,
          "address": address,
          "date": date,
          "villaNumber": villaNumber,
        },
      );
      final dynamic raw = res is Response ? res.data : res;
      final ownerJson = raw['data'] ?? raw;

      return Right(
        Person.fromJson(Map<String, dynamic>.from(ownerJson as Map)),
      );
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SecurityGuardModel>> addsecurity({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required MultipartFile? image,
    required String gateNumber,
  }) async {
    try {
      // جهّز الـ FormData
      final form = FormData.fromMap({
        'UserName': name,
        'Email': email,
        'Password': password,
        'PhoneNumber': phoneNumber,
        'GateNumber': gateNumber,
        if (image != null) 'Image': image, // غيّر اسم الحقل لو الـ API مختلف
      });

      final res = await dioConsumer.post(
        EndPoint.addsecuritygard,
        data: form,
        options: Options(contentType: 'multipart/form-data'),
      );
      final dynamic raw = res is Response ? res.data : res;
      final ownerJson = raw['data'] ?? raw;

      return Right(
        SecurityGuardModel.fromJson(
          Map<String, dynamic>.from(ownerJson as Map),
        ),
      );
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Failure _handleDioError(DioException error) =>
      ServerFailure(error.message ?? 'Unknown error occurred');
}
