part of 'person_cubit.dart';

abstract class PersonState {}

class PersonInitial extends PersonState {}

class PersonLoading extends PersonState {}

class Allmemberssuccful extends PersonState {
  final PersonPageSize personPageSize;
  Allmemberssuccful({required this.personPageSize});
}

class Allmembersfailure extends PersonState {
  final String message;
  Allmembersfailure({required this.message});
}

class DeleteSuccess extends PersonState {
  final String message;
  DeleteSuccess({required this.message});
}

class Deletefailure extends PersonState {
  final Failure failure;
  Deletefailure({required this.failure});
}

class UpdateSuccessful extends PersonState {
  final Person person;
  UpdateSuccessful({required this.person});
}

class UpdateUserFail extends PersonState {
  final String message;
  UpdateUserFail({required this.message});
}

class CreateBondSuccess extends PersonState {
  final String message;
  CreateBondSuccess({required this.message});
}

class CreateBondFail extends PersonState {
  final String message;
  CreateBondFail({required this.message});
}

class ReceiptBondSuccess extends PersonState {
  final BondPageModel data;
  ReceiptBondSuccess({required this.data});
}

class ReceiptBondFail extends PersonState {
  final String message;
  ReceiptBondFail({required this.message});
}

class DisbursementBondSuccess extends PersonState {
  final BondPageModel data;
  DisbursementBondSuccess({required this.data});
}

class DisbursementBondFail extends PersonState {
  final String message;
  DisbursementBondFail({required this.message});
}

class CreateBoncompounddSuccess extends PersonState {
  final String message;
  CreateBoncompounddSuccess({required this.message});
}

class CreateBondcompoundFail extends PersonState {
  final String message;
  CreateBondcompoundFail({required this.message});
}
class CompoundDisbursementBondsPageFail extends PersonState{

  final String message;

  CompoundDisbursementBondsPageFail({required this.message});

}
class CompoundDisbursementBondsPageSuccess extends PersonState {
  final CompoundDisbursementBondsPageModel data;
  CompoundDisbursementBondsPageSuccess({required this.data});
}
class SummarybondbyvillanumberFail extends PersonState{final String message;

  SummarybondbyvillanumberFail({required this.message});}

class Summarybondbyvillanumbersuccful extends PersonState{
  final List<BondsSummaryByYearModel>data;

  Summarybondbyvillanumbersuccful({required this.data});

}