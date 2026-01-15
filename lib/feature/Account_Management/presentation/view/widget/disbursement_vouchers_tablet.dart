import 'package:flutter/material.dart' hide DataCell;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehana_dashboared/core/const/widget/table/headercell.dart'
    show HeaderCell;
import 'package:rehana_dashboared/core/const/widget/table/data_cell.dart'
    show DataCell;
import '../../../../../core/const/paginationcontrols.dart';
import '../../../../../core/utils/colors/colors.dart';
import 'package:rehana_dashboared/l10n/app_localizations.dart';
import '../../manger/person_cubit.dart';
import 'bonds_search_filter.dart';

class DisbursementVouchersTablet extends StatefulWidget {
  const DisbursementVouchersTablet({super.key});

  @override
  State<DisbursementVouchersTablet> createState() =>
      _DisbursementVouchersTabletState();
}

class _DisbursementVouchersTabletState
    extends State<DisbursementVouchersTablet> {
  @override
  void initState() {
    super.initState();
    final personCubit = context.read<PersonCubit>();
    personCubit.getAllDisbursementBonds(personCubit.pageSize);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonCubit, PersonState>(
      builder: (context, state) {
        final personCubit = context.read<PersonCubit>();

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              BondsSearchFilter(
                onSearch: (villaNumber, memberName, fromDate, toDate) {
                  personCubit.updateSearchFilters(
                    villaNumber: villaNumber,
                    memberName: memberName,
                    fromDate: fromDate,
                    toDate: toDate,
                  );
                  personCubit.currentPage = 1;
                  personCubit.getAllDisbursementBonds(1);
                },
                onClear: () {
                  personCubit.clearSearchFilters();
                  personCubit.currentPage = 1;
                  personCubit.getAllDisbursementBonds(1);
                },
              ),
              Expanded(
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
                                  text:
                                      AppLocalizations.of(
                                        context,
                                      )!.voucher_date,
                                  flex: 2,
                                ),
                                HeaderCell(
                                  text: AppLocalizations.of(context)!.currency,
                                ),
                                HeaderCell(
                                  text: AppLocalizations.of(context)!.creditor,
                                ), // اسم العضو
                                HeaderCell(
                                  text:
                                      AppLocalizations.of(context)!.account_num,
                                ), // المبلغ
                                HeaderCell(
                                  text:
                                      AppLocalizations.of(
                                        context,
                                      )!.villa_number,
                                ),
                                HeaderCell(
                                  text:
                                      AppLocalizations.of(context)!.description,
                                ), // وصف السند
                                HeaderCell(
                                  text: AppLocalizations.of(context)!.type,
                                ), // نوع السند
                              ],
                            ),
                          ),
                        ),
                        if (state is PersonLoading)
                          const SliverFillRemaining(
                            hasScrollBody: false,
                            child: Center(child: CircularProgressIndicator()),
                          ),
                        if (state is DisbursementBondSuccess)
                          // Data rows
                          SliverList.separated(
                            itemCount: state.data.items.length,
                            itemBuilder: (context, index) {
                              final row = state.data.items[index];
                              final bgColor =
                                  index.isOdd
                                      ? const Color(0xFFF6F9ED)
                                      : Colors.white;

                              return Container(
                                color: bgColor,
                                child: Row(
                                  children: [
                                    DataCell(text: row.date, flex: 2),
                                    DataCell(text: row.currency),
                                    DataCell(text: row.memberName),
                                    DataCell(text: row.amount.toString()),
                                    DataCell(text: row.villaNumber.toString()),
                                    DataCell(text: row.bondDescription),
                                    DataCell(
                                      text:
                                          row.type == "Disbursement"
                                              ? AppLocalizations.of(
                                                context,
                                              )!.payment_bond
                                              : row.type,
                                    ),
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

                        if (state is DisbursementBondSuccess)
                          PaginationControls(
                            currentPage: personCubit.currentPage,
                            totalPages: state.data.totalPages,
                            onNext:
                                personCubit.nextPagegetgetAllDisbursementBonds,
                            onPrevious:
                                personCubit
                                    .previousPagegetgetAllDisbursementBonds,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
