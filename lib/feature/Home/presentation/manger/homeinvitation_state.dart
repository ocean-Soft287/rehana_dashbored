part of 'homeinvitation_cubit.dart';

sealed class HomeinvitationState {}

final class HomeinvitationInitial extends HomeinvitationState {}

class Invitationsuccful extends HomeinvitationState{
  final PaginatedVisitInvitations paginatedVisitInvitations;

  Invitationsuccful({required this.paginatedVisitInvitations});
}


class Invitationfailure extends HomeinvitationState{
  final String message;

  Invitationfailure({required this.message});
}





