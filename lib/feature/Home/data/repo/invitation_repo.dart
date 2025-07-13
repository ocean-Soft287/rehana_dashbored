import 'package:dartz/dartz.dart';
import 'package:rehana_dashboared/core/utils/Failure/failure.dart';
import '../model/pagevisit_invitation.dart';

abstract class Invitationrepo {
  Future<Either<Failure, PaginatedVisitInvitations>> getinvitation(int page, int pageSize);
}