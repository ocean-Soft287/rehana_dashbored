import 'package:dartz/dartz.dart';
import 'package:rehana_dashboared/core/utils/Failure/failure.dart';
import 'package:rehana_dashboared/feature/add_users/data/model/person_model.dart';
import '../model/bondpagemodel.dart';
import '../model/bonds_summary_by_year_model.dart';
import '../model/compound_disbursement_bonds_page_model.dart';
import '../model/person_page_size.dart';

abstract class AccountMangmentrepo {
  Future<Either<Failure, PersonPageSize>> getallmemberaccounts(
    int page,
    int pageSize,
  );
  Future<Either<Failure, String>> deleteaccountmember(int id);
  Future<Either<Failure, Person>> updatememberaccounts({
    required String id,
    required String fullName,
    required String phoneNumber,
    required bool isMarried,
    required String address,
    required String date,
    required int villaNumber,
  });

  Future<Either<Failure, String>> createBond({
    required String date,
    required String currency,
    required double amount,
    required int villaNumber,
    required String type,
    required String bondDescription,
  });
  Future<Either<Failure, BondPageModel>> getallmemberreceiptbonds(
    int page,
    int pagesize,
  );
  Future<Either<Failure, BondPageModel>> getallMemberdisbursementBonds(
    int page,
    int pagesize,
  );
  Future<Either<Failure, String>> createBondcompound({
    required String date,
    required String currency,
    required double amount,
  });
  Future<Either<Failure, CompoundDisbursementBondsPageModel>>
  getCompoundDisbursementBonds(int page, int pagesize);
  Future<Either<Failure, List<BondsSummaryByYearModel>>>
  getbondssummarybyyearbyvillanumber(int villaNumber);

  Future<Either<Failure, List<dynamic>>> getVillasList();
  Future<Either<Failure, String>> bulkDisbursement({
    required List<String> villaNumbers,
    required double pricePerMeter,
    required String date,
    required String currency,
    required String bondDescription,
  });
}
