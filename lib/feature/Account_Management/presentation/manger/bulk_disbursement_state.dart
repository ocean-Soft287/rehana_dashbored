import 'package:equatable/equatable.dart';
import 'package:rehana_dashboared/feature/Account_Management/data/model/villa_list_model.dart';

abstract class BulkDisbursementState extends Equatable {
  const BulkDisbursementState();

  @override
  List<Object?> get props => [];
}

class BulkDisbursementInitial extends BulkDisbursementState {}

class VillasListLoading extends BulkDisbursementState {}

class VillasListLoaded extends BulkDisbursementState {
  final List<VillaListModel> villas;

  const VillasListLoaded(this.villas);

  @override
  List<Object?> get props => [villas];
}

class VillasListError extends BulkDisbursementState {
  final String message;

  const VillasListError(this.message);

  @override
  List<Object?> get props => [message];
}

class BulkDisbursementLoading extends BulkDisbursementState {}

class BulkDisbursementSuccess extends BulkDisbursementState {
  final String message;

  const BulkDisbursementSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class BulkDisbursementError extends BulkDisbursementState {
  final String message;

  const BulkDisbursementError(this.message);

  @override
  List<Object?> get props => [message];
}
