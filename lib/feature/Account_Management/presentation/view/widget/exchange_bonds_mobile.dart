import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehana_dashboared/core/const/widget/mobile_table/row_item.dart'
    show RowItem;
import '../../../../../core/const/paginationcontrols.dart';
import 'package:rehana_dashboared/l10n/app_localizations.dart';
import '../../../../Home/data/model/visitrow_model.dart';
import '../../manger/person_cubit.dart';
import 'package:rehana_dashboared/core/const/widget/mobile_table/row_item.dart';

class ExchangeBondsMobile extends StatefulWidget {
  const ExchangeBondsMobile({super.key, required this.rows});
  final List<VisitRow> rows;

  @override
  State<ExchangeBondsMobile> createState() => _ExchangeBondsMobileState();
}

class _ExchangeBondsMobileState extends State<ExchangeBondsMobile> {
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
                  if (state is DisbursementBondSuccess)
                    SliverList.separated(
                      itemCount: state.data.items.length,
                      itemBuilder: (context, index) {
                        final row = state.data.items[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.07),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                            border: Border.all(color: const Color(0xFFE2E2E2)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                RowItem(label:AppLocalizations.of(context)!.voucher_date, value: row.date),
                                RowItem(label:AppLocalizations.of(context)!.currency, value: row.currency),
                                RowItem(label:AppLocalizations.of(context)!.account_num, value: row.amount.toString()),
                                RowItem(label:AppLocalizations.of(context)!.debtor, value: row.memberName),
                                RowItem(label:AppLocalizations.of(context)!.description, value: row.bondDescription),
                                RowItem(label:AppLocalizations.of(context)!.type, value: row.type == "Disbursement" ?AppLocalizations.of(context)!.disbursement : row.type),
                                RowItem(label:AppLocalizations.of(context)!.villa_number, value: row.villaNumber.toString()),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 8),
                    ),

                  if (state is DisbursementBondSuccess)
                    PaginationControls(
                      currentPage: personCubit.currentPage,
                      totalPages: state.data.totalPages,
                      onNext: personCubit.nextPagegetgetAllDisbursementBonds,
                      onPrevious: personCubit.previousPagegetgetAllDisbursementBonds,
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
