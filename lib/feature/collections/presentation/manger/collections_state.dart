part of 'collections_cubit.dart';

@immutable
abstract class CollectionsState {}

class CollectionsInitial extends CollectionsState {}

class CollectionsLoadingVillas extends CollectionsState {}

class CollectionsVillasLoaded extends CollectionsState {
  final List<VillaModel> villas;

  CollectionsVillasLoaded(this.villas);
}

class CollectionsSubmitting extends CollectionsState {}

class CollectionsSuccess extends CollectionsState {
  final String message;

  CollectionsSuccess(this.message);
}

class CollectionsError extends CollectionsState {
  final String message;

  CollectionsError(this.message);
}
