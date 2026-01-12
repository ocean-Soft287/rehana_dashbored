import 'package:dartz/dartz.dart';
import '../../../../core/utils/Failure/failure.dart';
import '../models/collection_request_model.dart';
import '../models/villa_model.dart';

abstract class CollectionsRepo {
  Future<Either<Failure, List<VillaModel>>> getVillasList();
  Future<Either<Failure, String>> createCollection(
    CollectionRequestModel request,
  );
}
