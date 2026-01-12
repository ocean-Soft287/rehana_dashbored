import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehana_dashboared/feature/Account_Management/data/model/villa_list_model.dart';
import 'package:rehana_dashboared/feature/Account_Management/data/repo/accountmangmentrepo.dart';
import 'bulk_disbursement_state.dart';

class BulkDisbursementCubit extends Cubit<BulkDisbursementState> {
  final AccountMangmentrepo repository;

  BulkDisbursementCubit(this.repository) : super(BulkDisbursementInitial());

  Future<void> fetchVillasList() async {
    emit(VillasListLoading());

    final result = await repository.getVillasList();

    result.fold((failure) => emit(VillasListError(failure.toString())), (data) {
      final villas =
          data
              .map(
                (json) => VillaListModel.fromJson(json as Map<String, dynamic>),
              )
              .toList();
      emit(VillasListLoaded(villas));
    });
  }

  Future<void> submitBulkDisbursement({
    required List<String> villaNumbers,
    required double pricePerMeter,
    required String date,
    required String bondDescription,
  }) async {
    emit(BulkDisbursementLoading());

    final result = await repository.bulkDisbursement(
      villaNumbers: villaNumbers,
      pricePerMeter: pricePerMeter,
      date: date,
      currency: "EGP",
      bondDescription: bondDescription,
    );

    result.fold(
      (failure) => emit(BulkDisbursementError(failure.toString())),
      (message) => emit(BulkDisbursementSuccess(message)),
    );
  }
}
