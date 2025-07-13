

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, Divider, Material;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;
import 'package:rehana_dashboared/core/const/paginationcontrols.dart' show PaginationControls;
import 'package:rehana_dashboared/core/const/widget/table/headercell.dart' show HeaderCell;
import 'package:rehana_dashboared/core/const/widget/table/data_cell.dart' show DataCell;
import 'package:rehana_dashboared/core/utils/colors/colors.dart' show Appcolors;
import 'package:rehana_dashboared/generated/l10n.dart' show S;

import '../../manger/person_cubit.dart';

class ReceiptBondForCompoundTablet extends StatefulWidget {
  const ReceiptBondForCompoundTablet({super.key});

  @override
  State<ReceiptBondForCompoundTablet> createState() => _ReceiptBondForCompoundTabletState();
}

class _ReceiptBondForCompoundTabletState extends State<ReceiptBondForCompoundTablet> {
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
                  // Header
                  SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Appcolors.kprimary,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          HeaderCell(text: S.of(context).voucher_date, flex: 2),
                          HeaderCell(text: S.of(context).currency),
                          HeaderCell(text: S.of(context).amount),
                        ],
                      ),
                    ),
                  ),

                  // Data Rows
                  if (state is CompoundDisbursementBondsPageSuccess)
                    SliverList.separated(
                      itemCount: state.data.items.length,
                      itemBuilder: (context, index) {
                        final row = state.data.items[index];
                        final bgColor = index.isOdd ? const Color(0xFFF6F9ED) : Colors.white;

                        return Container(
                          color: bgColor,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              DataCell(text: row.date, flex: 2),
                              DataCell(text: row.currency),
                              DataCell(text: row.amount.toString()),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => const Divider(height: 0, color: Color(0xFFE2E2E2)),
                    ),

                  // Pagination
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
