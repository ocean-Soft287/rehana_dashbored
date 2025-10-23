import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/const/paginationcontrols.dart';
import '../../../../../core/const/widget/mobile_table/row_item.dart';
import 'package:rehana_dashboared/l10n/app_localizations.dart';
import '../../manger/person_cubit.dart';

class ReceiptBondForCompoundMobile extends StatefulWidget {
  const ReceiptBondForCompoundMobile({super.key});

  @override
  State<ReceiptBondForCompoundMobile> createState() => _ReceiptBondForCompoundMobileState();
}

class _ReceiptBondForCompoundMobileState extends State<ReceiptBondForCompoundMobile> {
  @override
  void initState() {
    super.initState();
    final personCubit = context.read<PersonCubit>();
    personCubit.getCompoundDisbursementBonds(personCubit.pageSize);
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
                  if (state is CompoundDisbursementBondsPageSuccess)
                    SliverList.separated(
                      itemCount: state.data.items.length,
                      itemBuilder: (context, index) {
                        final row = state.data.items[index];


                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues( alpha:0.07),
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
                                RowItem(label:AppLocalizations.of(context)!.creditor, value: row.amount.toString()),

                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(),
                    ),
                  if (state is CompoundDisbursementBondsPageSuccess)
                    PaginationControls(
                      currentPage: personCubit.currentPage,
                      totalPages: state.data.totalPages,
                      onNext: personCubit.nextPagegetCompoundDisbursementBonds,
                      onPrevious: personCubit.previousgetCompoundDisbursementBonds,
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
