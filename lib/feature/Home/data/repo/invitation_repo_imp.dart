import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rehana_dashboared/core/utils/Failure/failure.dart';
import 'package:rehana_dashboared/feature/Home/data/repo/invitation_repo.dart';
import '../../../../core/utils/api/dio_consumer.dart';
import '../../../../core/utils/api/endpoint.dart';
import '../model/pagevisit_invitation.dart';


class Invitationrepoimp implements Invitationrepo {
  final DioConsumer dioConsumer;

  Invitationrepoimp({required this.dioConsumer});

  @override
  Future<Either<Failure, PaginatedVisitInvitations>> getinvitation(int page, int pageSize) async {
    try {
      final response = await dioConsumer.get(
        "${EndPoint.allInvitations}$page&pageSize=$pageSize",
      );

      final json = response as Map<String, dynamic>;
      final model = PaginatedVisitInvitations.fromJson(json);
      return right(model);
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(ServerFailure("${e.toString()}"));
    }
  }

  Failure _handleDioError(DioException error) {
    return ServerFailure(error.message ?? "Unknown error occurred");
  }
}
