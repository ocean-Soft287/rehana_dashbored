import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rehana_dashboared/core/utils/Failure/failure.dart';
import 'package:rehana_dashboared/core/utils/api/dio_consumer.dart';
import 'package:rehana_dashboared/feature/Account_Management/data/model/bondpagemodel.dart';
import 'package:rehana_dashboared/feature/Account_Management/data/model/bonds_summary_by_year_model.dart';
import 'package:rehana_dashboared/feature/Account_Management/data/model/compound_disbursement_bonds_page_model.dart';
import 'package:rehana_dashboared/feature/Account_Management/data/model/person_page_size.dart';
import '../../../../core/utils/api/endpoint.dart';
import '../../../add_users/data/model/person_model.dart';
import 'accountmangmentrepo.dart';

class AccountMangmentrepoimp implements AccountMangmentrepo {
  final DioConsumer dioConsumer;

  AccountMangmentrepoimp({required this.dioConsumer});
  @override
  Future<Either<Failure, PersonPageSize>> getallmemberaccounts(
    int page,
    int pageSize,
  ) async {
    try {
      final response = await dioConsumer.get(
        "${EndPoint.getAllMemberAccounts}$page&pageSize=$pageSize",
      );

      final json = response as Map<String, dynamic>;
      final model = PersonPageSize.fromJson(json);
      return right(model);
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  Failure _handleDioError(DioException error) =>
      ServerFailure(error.message ?? 'Unknown error occurred');

  @override
  Future<Either<Failure, String>> deleteaccountmember(int id) async {
    try {
      final response = await dioConsumer.delete(
        "${EndPoint.deleteMemberAccount}$id",
      );
      if (response == "Account Deleted Successfully") {
        return Right(response);
      } else {
        return Left(ServerFailure("Unexpected response: $response"));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  @override
  Future<Either<Failure, Person>> updatememberaccounts({
    required String id,
    required String fullName,
    required String phoneNumber,
    required bool isMarried,
    required String address,
    required String date,
    required int villaNumber,
  }) async {
    try {
      final response = await dioConsumer.post(
        EndPoint.updateMemberAccount,
        data: {
          "id": id,
          "fullName": fullName,
          "phoneNumber": phoneNumber,
          "isMarried": isMarried,
          "address": address,
          "date": date,
          "villaNumber": villaNumber,
        },
      );

      final json = response as Map<String, dynamic>;

      final model = Person.fromJson(json);

      return right(model);
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(ServerFailure("Update failed: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, String>> createBond({
    required String date,
    required String currency,
    required double amount,
    required int villaNumber,
    required String type,
    required String bondDescription,
  }) async {
    try {
      final response = await dioConsumer.post(
        EndPoint.createBondForMember,
        data: {
          "date": date,
          "currency": currency,
          "amount": amount,
          "villaNumber": villaNumber,
          "type": type,
          "bondDescription": bondDescription,
        },
      );

      if (response == "Member Bond Created Successfully") {
        return Right(response);
      } else {
        return Left(ServerFailure("Unexpected response: $response"));
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(ServerFailure("Create bond failed: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, BondPageModel>> getallmemberreceiptbonds(
    int page,
    int pagesize, {
    String? villaNumber,
    String? memberName,
    String? fromDate,
    String? toDate,
  }) async {
    try {
      String url =
          "${EndPoint.getallmemberreceiptbonds}$page&pageSize=$pagesize";

      if (villaNumber != null && villaNumber.isNotEmpty) {
        url += "&villaNumber=$villaNumber";
      }
      if (memberName != null && memberName.isNotEmpty) {
        url += "&memberName=$memberName";
      }
      if (fromDate != null && fromDate.isNotEmpty) {
        url += "&fromDate=$fromDate";
      }
      if (toDate != null && toDate.isNotEmpty) {
        url += "&toDate=$toDate";
      }

      final response = await dioConsumer.get(url);

      final json = response as Map<String, dynamic>;
      final model = BondPageModel.fromJson(json);
      return right(model);
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BondPageModel>> getallMemberdisbursementBonds(
    int page,
    int pagesize, {
    String? villaNumber,
    String? memberName,
    String? fromDate,
    String? toDate,
  }) async {
    try {
      String url =
          "${EndPoint.getallMemberdisbursementBonds}$page&pageSize=$pagesize";

      if (villaNumber != null && villaNumber.isNotEmpty) {
        url += "&villaNumber=$villaNumber";
      }
      if (memberName != null && memberName.isNotEmpty) {
        url += "&memberName=$memberName";
      }
      if (fromDate != null && fromDate.isNotEmpty) {
        url += "&fromDate=$fromDate";
      }
      if (toDate != null && toDate.isNotEmpty) {
        url += "&toDate=$toDate";
      }

      final response = await dioConsumer.get(url);

      final json = response as Map<String, dynamic>;
      final model = BondPageModel.fromJson(json);
      return right(model);
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> createBondcompound({
    required String date,
    required String currency,
    required double amount,
  }) async {
    try {
      final response = await dioConsumer.post(
        EndPoint.addCompoundDisbursementBond,
        data: {"date": date, "currency": currency, "amount": amount},
      );

      if (response == "Owner Disbursement Bond Created Successfully") {
        return Right(response);
      } else {
        return Left(ServerFailure("Unexpected response: $response"));
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(ServerFailure("Create bond failed: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, CompoundDisbursementBondsPageModel>>
  getCompoundDisbursementBonds(int page, int pagesize) async {
    try {
      final response = await dioConsumer.get(
        "${EndPoint.compounddisbursementbonds}$page&pageSize=$pagesize",
      );

      final json = response as Map<String, dynamic>;
      final model = CompoundDisbursementBondsPageModel.fromJson(json);
      return right(model);
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BondsSummaryByYearModel>>>
  getbondssummarybyyearbyvillanumber(int villaNumber) async {
    try {
      final rawList =
          await dioConsumer.get(
                "${EndPoint.getbondssummarybyyearbyvillanumber}$villaNumber",
              )
              as List<dynamic>;

      final bpmdsummarybyyearmodel =
          rawList
              .map(
                (json) => BondsSummaryByYearModel.fromJson(
                  json as Map<String, dynamic>,
                ),
              )
              .toList();

      return right(bpmdsummarybyyearmodel);
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<dynamic>>> getVillasList() async {
    try {
      final response = await dioConsumer.get(EndPoint.villasList);
      final list = response as List<dynamic>;
      return right(list);
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> bulkDisbursement({
    required List<String> villaNumbers,
    required double pricePerMeter,
    required String date,
    required String currency,
    required String bondDescription,
  }) async {
    try {
      final response = await dioConsumer.post(
        EndPoint.bulkDisbursement,
        data: {
          "villaNumbers": villaNumbers,
          "pricePerMeter": pricePerMeter,
          "date": date,
          "currency": currency,
          "bondDescription": bondDescription,
        },
      );

      return Right(response.toString());
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(ServerFailure("Bulk disbursement failed: ${e.toString()}"));
    }
  }
}
