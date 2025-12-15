import 'package:flutter/material.dart' hide DataCell;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehana_dashboared/core/const/widget/table/data_cell.dart';
import 'package:rehana_dashboared/core/const/widget/table/headercell.dart';
import 'package:rehana_dashboared/core/extenisons/date_time_extensions.dart';
import 'package:rehana_dashboared/core/utils/colors/colors.dart';

import '../../../../../core/const/paginationcontrols.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../manger/homeinvitation_cubit.dart';

class TabletHome extends StatefulWidget {
  const TabletHome({super.key});

  @override
  State<TabletHome> createState() => _TabletHomeState();
}

class _TabletHomeState extends State<TabletHome> {
  @override
  void initState() {
    super.initState();
    context.read<HomeinvitationCubit>().getinvitationpage(
      context.read<HomeinvitationCubit>().currentPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeinvitationCubit, HomeinvitationState>(
      buildWhen: (previous, current) => current != previous,
      builder: (context, state) {
        final homeinvitation = context.read<HomeinvitationCubit>();

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: CustomScrollView(
                slivers: [
                  // Header
                  SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Appcolors.kprimary,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      child: Row(

                          children: [
                          HeaderCell(
                            text: AppLocalizations.of(context)!.villa_number,

                          ),
                          HeaderCell(text: AppLocalizations.of(context)!.name),
                          HeaderCell(text: AppLocalizations.of(context)!.time),
                          HeaderCell(
                            text:
                                AppLocalizations.of(context)!.reason_for_visit,
                          ),
                          HeaderCell(
                            text: AppLocalizations.of(context)!.status,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Data rows
                  if (state is Invitationsuccful)
                    SliverList.separated(
                      itemCount: state.paginatedVisitInvitations.items.length,
                      itemBuilder: (context, index) {
                        final item =
                            state.paginatedVisitInvitations.items[index];

                        final bgColor =
                            index.isOdd
                                ? const Color(0xFFF6F9ED)
                                : Colors.white;

                        return Container(
                          color: bgColor,
                          child: Row(
                            children: [
                              DataCell(text: item.memberVillaNumber.toString()),
                              Container(
                                width: 2,
                                height: 130,
                                decoration: const BoxDecoration(
                                  color: Appcolors.kprimary,
                                ),
                              ),
                              DataCell(text: item.memberUserName),
                              Container(
                                width: 2,
                                height: 130,
                                decoration: const BoxDecoration(
                                  color: Appcolors.kprimary,
                                ),
                              ),
                              DataCell(
                                text:
                                    " ${item.dateFrom.toCustomFormat()} - ${item.dateTo.toCustomFormat()}",
                              ),

                              Container(
                                width: 2,
                                height: 130,
                                decoration: const BoxDecoration(
                                  color: Appcolors.kprimary,
                                ),
                              ),
                              DataCell(text: item.reasonForVisit),
                              Container(
                                width: 2,
                                height: 130,
                                decoration: const BoxDecoration(
                                  color: Appcolors.kprimary,
                                ),
                              ),
                              DataCell(text: item.status),
                            ],
                          ),
                        );
                      },
                      separatorBuilder:
                          (context, index) => const Divider(
                            height: 0,
                            color: Color(0xFFE2E2E2),
                          ),
                    ),

                  SliverToBoxAdapter(child: SizedBox(height: 50)),

                  // Pagination
                  if (state is Invitationsuccful)
                    PaginationControls(
                      currentPage: homeinvitation.currentPage,
                      totalPages: state.paginatedVisitInvitations.totalPages,
                      onNext: homeinvitation.nextPage,
                      onPrevious: homeinvitation.previousPage,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
