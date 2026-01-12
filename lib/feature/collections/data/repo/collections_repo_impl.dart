import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/utils/Failure/failure.dart';
import '../../../../core/utils/api/dio_consumer.dart';
import '../../../../core/utils/api/endpoint.dart';
import '../models/collection_request_model.dart';
import '../models/villa_model.dart';
import 'collections_repo.dart';

class CollectionsRepoImpl implements CollectionsRepo {
  final DioConsumer dioConsumer;

  CollectionsRepoImpl({required this.dioConsumer});

  @override
  Future<Either<Failure, List<VillaModel>>> getVillasList() async {
    try {
      final response = await dioConsumer.get(EndPoint.villasList);

      if (response is List) {
        final villas =
            response
                .map(
                  (item) => VillaModel.fromJson(item as Map<String, dynamic>),
                )
                .toList();
        return right(villas);
      }

      return left(ServerFailure("Invalid response format"));
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(ServerFailure("Error loading villas: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, String>> createCollection(
    CollectionRequestModel request,
  ) async {
    try {
      final response = await dioConsumer.post(
        EndPoint.createCollection,
        data: request.toJson(),
      );

      return right(response.toString());
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(ServerFailure("Error creating collection: ${e.toString()}"));
    }
  }

  Failure _handleDioError(DioException error) {
    if (error.response != null) {
      final statusCode = error.response!.statusCode;
      switch (statusCode) {
        case 400:
          return ServerFailure("بيانات غير صحيحة");
        case 401:
          return ServerFailure("غير مصرح لك بهذه العملية");
        case 404:
          return ServerFailure("الخدمة غير موجودة");
        case 500:
          return ServerFailure("خطأ في السيرفر");
        default:
          return ServerFailure(
            error.response!.data?.toString() ?? "خطأ غير معروف",
          );
      }
    }
    return ServerFailure(error.message ?? "خطأ غير معروف");
  }
}
