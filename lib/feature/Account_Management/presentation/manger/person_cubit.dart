

import 'package:bloc/bloc.dart';
import 'package:rehana_dashboared/core/utils/Failure/failure.dart';
import 'package:rehana_dashboared/feature/Account_Management/data/model/bonds_summary_by_year_model.dart';
import 'package:rehana_dashboared/feature/add_users/data/model/person_model.dart';

import '../../data/model/bondpagemodel.dart';
import '../../data/model/compound_disbursement_bonds_page_model.dart';
import '../../data/model/person_page_size.dart';
import '../../data/repo/accountmangmentrepo.dart';

part 'person_state.dart';


class PersonCubit extends Cubit<PersonState> {
  PersonCubit(this.accountMangmentrepo) : super(PersonInitial());
  final AccountMangmentrepo accountMangmentrepo;
  int currentPage = 1;
  final int pageSize = 20;

  void nextPage() {
    currentPage++;
    getallmemberaccounts(currentPage);
  }

  void previousPage() {
    if (currentPage > 1) {
      currentPage--;
      getallmemberaccounts(currentPage);
    }
  }

  Future<void> getallmemberaccounts(int currentPage) async {
    final response = await accountMangmentrepo.getallmemberaccounts(
      currentPage,
      pageSize,
    );
    response.fold(
          (failure) {
        emit(Allmembersfailure(message: failure.message));
      },
          (paginatedVisitInvitations) {
        emit(Allmemberssuccful(personPageSize: paginatedVisitInvitations));
      },
    );
  }

  Future<void> deleteid(int id) async {
    final response = await accountMangmentrepo.deleteaccountmember(id);
    response.fold(
          (failure) {
        emit(Deletefailure(failure: failure));
      },
          (message) {
        emit(DeleteSuccess(message: message));
        getallmemberaccounts(currentPage);
      },
    );
  }


  Future<void> update({
    required String id,
    required String fullName,
    required String phoneNumber,
    required bool isMarried,
    required String address,
    required String date,
    required int villaNumber,
  }) async {
    final response = await accountMangmentrepo.updatememberaccounts(
      id: id,
      fullName: fullName,
      phoneNumber: phoneNumber,
      isMarried: isMarried,
      address: address,
      date: date,
      villaNumber: villaNumber,
    );
    response.fold(
          (failure) {
        emit(UpdateUserFail(message: failure.message));
      },
          (person) {
        emit(UpdateSuccessful(person: person));
      },
    );
  }
  Future<void> createBondcompounds({
    required String date,
    required String currency,
    required double amount,
  }) async {
    final response = await accountMangmentrepo.createBondcompound(
      date: date,
      currency: currency,
      amount: amount,
    );

    response.fold(
          (failure) {
        emit(CreateBondcompoundFail(message: failure.message));
      },
          (message) {
        emit(CreateBoncompounddSuccess(message: message));
      },
    );
  }


  Future<void> createBond({
    required String date,
    required String currency,
    required double amount,
    required int villaNumber,
    required String type,
    required String bondDescription,
  }) async {
    final response = await accountMangmentrepo.createBond(
      date: date,
      currency: currency,
      amount: amount,
      villaNumber: villaNumber,
      type: type,
      bondDescription: bondDescription,
    );

    response.fold(
          (failure) {
        emit(CreateBondFail(message: failure.message));
      },
          (message) {
        emit(CreateBondSuccess(message: message));
      },
    );
  }

  Future<void> getAllReceiptBonds(int page) async {
    final response = await accountMangmentrepo.getallmemberreceiptbonds(currentPage, pageSize);

    response.fold(
          (failure) {
        emit(ReceiptBondFail(message: failure.message));
      },
          (bonds) {
        emit(ReceiptBondSuccess(data: bonds));
      },
    );
  }
  void nextPagegetAllReceiptBonds() {
    currentPage++;
    getAllReceiptBonds(currentPage);
  }

  void previousPagegetAllReceiptBonds() {
    if (currentPage > 1) {
      currentPage--;
      getAllReceiptBonds(currentPage);
    }
  }

  Future<void> getAllDisbursementBonds(int page) async {
    final response = await accountMangmentrepo.      getallMemberdisbursementBonds(currentPage, pageSize);

    response.fold(
          (failure) {
        emit(DisbursementBondFail(message: failure.message));
      },
          (bonds) {
        emit(DisbursementBondSuccess(data: bonds));
      },
    );
  }

  void nextPagegetgetAllDisbursementBonds() {
    currentPage++;
    getAllDisbursementBonds(currentPage);
  }

  void previousPagegetgetAllDisbursementBonds() {
    if (currentPage > 1) {
      currentPage--;
      getAllDisbursementBonds(currentPage);
    }
  }


  Future<void> getCompoundDisbursementBonds(int page)async{
    final response = await accountMangmentrepo.getCompoundDisbursementBonds(currentPage, pageSize);

    response.fold(
          (failure) {
        emit(CompoundDisbursementBondsPageFail(message: failure.message));
      },
          (compounddisbursementbondspagemodel) {
        emit(CompoundDisbursementBondsPageSuccess(data: compounddisbursementbondspagemodel));
      },
    );

  }
  void nextPagegetCompoundDisbursementBonds() {
    currentPage++;
    getCompoundDisbursementBonds(currentPage);
  }

  void previousgetCompoundDisbursementBonds() {
    if (currentPage > 1) {
      currentPage--;
      getCompoundDisbursementBonds(currentPage);
    }
  }
  Future<void>getsummarybondbyvillanumber(int villanumber)async{
    final response=await accountMangmentrepo.getbondssummarybyyearbyvillanumber(villanumber);

    response.fold(  (failure) {
      emit(SummarybondbyvillanumberFail(message: failure.message));
    },
        (boundsummary){
      emit(Summarybondbyvillanumbersuccful(data: boundsummary));
        });
  }
}
