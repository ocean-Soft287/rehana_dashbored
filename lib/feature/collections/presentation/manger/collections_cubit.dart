import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/models/collection_request_model.dart';
import '../../data/models/villa_model.dart';
import '../../data/repo/collections_repo.dart';

part 'collections_state.dart';

class CollectionsCubit extends Cubit<CollectionsState> {
  final CollectionsRepo collectionsRepo;

  CollectionsCubit(this.collectionsRepo) : super(CollectionsInitial());

  Future<void> loadVillas() async {
    emit(CollectionsLoadingVillas());

    final result = await collectionsRepo.getVillasList();

    result.fold(
      (failure) => emit(CollectionsError(failure.message)),
      (villas) => emit(CollectionsVillasLoaded(villas)),
    );
  }

  Future<void> createCollection({
    required String villaNumber,
    required double amount,
    required String date,
    required String bondDescription,
  }) async {
    emit(CollectionsSubmitting());

    final request = CollectionRequestModel(
      villaNumber: villaNumber,
      amount: amount,
      date: date,
      currency: 'EGP',
      bondDescription: bondDescription,
    );

    final result = await collectionsRepo.createCollection(request);

    result.fold(
      (failure) => emit(CollectionsError(failure.message)),
      (message) => emit(CollectionsSuccess(message)),
    );
  }
}
