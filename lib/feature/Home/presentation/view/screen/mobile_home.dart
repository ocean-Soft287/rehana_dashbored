import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/const/paginationcontrols.dart';
import '../../../../../core/const/widget/mobile_table/visit_card.dart';
import '../../manger/homeinvitation_cubit.dart';

class MobileHome extends StatefulWidget {
  const MobileHome({super.key});

  @override
  State<MobileHome> createState() => _MobileHomeState();
}

class _MobileHomeState extends State<MobileHome> {
  @override
  void initState() {
    super.initState();
    final homeinvitation = context.read<HomeinvitationCubit>();
    homeinvitation.getinvitationpage(homeinvitation.currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeinvitationCubit, HomeinvitationState>(
      buildWhen: (previous, current) => current != previous,
      builder: (context, state) {
        final homeinvitation = context.read<HomeinvitationCubit>();

        if (state is Invitationsuccful) {
          final invitations = state.paginatedVisitInvitations.items;

          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList.separated(
                  itemCount: invitations.length,
                  separatorBuilder:
                      (context, index) => const SizedBox(height: 10),
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
              ),
            ],
          );
        }

        if (state is HomeinvitationInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        return const SizedBox();
      },
    );
  }
}
