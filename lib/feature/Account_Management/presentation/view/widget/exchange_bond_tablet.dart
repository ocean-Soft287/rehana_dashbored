import 'package:flutter/material.dart' show Colors, Divider, Material;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehana_dashboared/core/const/widget/table/headercell.dart' show HeaderCell;
import 'package:rehana_dashboared/core/const/widget/table/data_cell.dart' show DataCell;
import 'package:rehana_dashboared/core/utils/colors/colors.dart' show Appcolors;

import '../../../../../core/const/paginationcontrols.dart';
import 'package:rehana_dashboared/l10n/app_localizations.dart';
import '../../../../Home/data/model/visitrow_model.dart';
import '../../manger/person_cubit.dart';


class ExchangeBondTablet extends StatefulWidget {
  const ExchangeBondTablet({super.key, required this.rows});
  final List<VisitRow> rows;

  @override
  State<ExchangeBondTablet> createState() => _ExchangeBondTabletState();
}

class _ExchangeBondTabletState extends State<ExchangeBondTablet> {
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
              // Header Row
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color: Appcolors.kprimary,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      HeaderCell(text:AppLocalizations.of(context)!.voucher_date, flex: 2),
                      HeaderCell(text:AppLocalizations.of(context)!.currency),
                      HeaderCell(text:AppLocalizations.of(context)!.debtor), // اسم العضو
                      HeaderCell(text:AppLocalizations.of(context)!.account_num), // المبلغ
                      HeaderCell(text:AppLocalizations.of(context)!.villa_number),
                      HeaderCell(text:AppLocalizations.of(context)!.description), // وصف السند
                      HeaderCell(text:AppLocalizations.of(context)!.type), // نوع السند
                    ],
                  ),

                ),
              ),
              if (state is DisbursementBondSuccess)
              SliverList.separated(
                itemCount: state.data.items.length,
                itemBuilder: (context, index) {
                  final row = state.data.items[index];
                  final bgColor =
                  index.isOdd ? const Color(0xFFF6F9ED) : Colors.white;
                  return Container(
                    color: bgColor,
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        DataCell(text: row.date, flex: 2),
                        DataCell(text: row.currency),
                        DataCell(text: row.memberName),
                        DataCell(text: row.amount.toString()),
                        DataCell(text: row.villaNumber.toString()),
                        DataCell(text: row.bondDescription),
                        DataCell(text: row.type=="Disbursement"?AppLocalizations.of(context)!.disbursement:AppLocalizations.of(context)!.disbursement),
                      ],
                    ),

                  );
                },
                separatorBuilder:
                    (context, index) =>
                const Divider(height: 0, color: Color(0xFFE2E2E2)),
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
