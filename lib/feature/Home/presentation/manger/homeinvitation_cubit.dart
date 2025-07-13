import 'package:bloc/bloc.dart';
import 'package:rehana_dashboared/feature/Home/data/repo/invitation_repo.dart';

import '../../data/model/pagevisit_invitation.dart';

part 'homeinvitation_state.dart';


class HomeinvitationCubit extends Cubit<HomeinvitationState> {
  HomeinvitationCubit(this.invitationrepo) : super(HomeinvitationInitial());

  final Invitationrepo invitationrepo;
  int currentPage = 1;
  final int pageSize = 20;

  void nextPage() {
    currentPage++;
    getinvitationpage(currentPage);
  }

  void previousPage() {
    if (currentPage > 1) {
      currentPage--;
      getinvitationpage(currentPage);
    }
  }

  Future<void> getinvitationpage(int page) async {
    final response = await invitationrepo.getinvitation(page, pageSize);
    response.fold(
          (failure) {
        emit(Invitationfailure(message: failure.message));
      },
          (paginatedVisitInvitations) {
        emit(Invitationsuccful(paginatedVisitInvitations: paginatedVisitInvitations));
      },
    );
  }
}
