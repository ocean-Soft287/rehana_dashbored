import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/const/paginationcontrols.dart';
import '../../../../../core/const/widget/mobile_table/visit_card.dart';
import '../../manger/homeinvitation_cubit.dart';


class MobileHome extends StatelessWidget {
  const MobileHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeinvitationCubit, HomeinvitationState>(
      builder: (context, state) {
        final homeinvitation = context.read<HomeinvitationCubit>();
        homeinvitation.getinvitationpage(homeinvitation.currentPage);

        if (state is Invitationsuccful) {
          final invitations = state.paginatedVisitInvitations.items;

          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList.separated(
                  itemCount: invitations.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final row = invitations[index];
                    return VisitCard(
                      isButtons: false,
                      onAccept: () {},
                      onReject: () {},
                      invitation: row,
                    );
                  },
                ),
              ),
              PaginationControls(
                currentPage: homeinvitation.currentPage,
                totalPages: state.paginatedVisitInvitations.totalPages,
                onNext: homeinvitation.nextPage,
                onPrevious: homeinvitation.previousPage,
              )
            ],
          );
        }

        return const SizedBox(); // Or loading spinner
      },
    );
  }
}

