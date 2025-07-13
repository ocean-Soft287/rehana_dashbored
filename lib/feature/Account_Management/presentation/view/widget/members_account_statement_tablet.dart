import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, Divider, Material, showDialog;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehana_dashboared/core/const/widget/table/headercell.dart' show HeaderCell;
import 'package:rehana_dashboared/core/const/widget/table/data_cell.dart' show DataCell;
import 'package:rehana_dashboared/core/const/widget/table/status_cell.dart' show StatusCell;
import 'package:rehana_dashboared/feature/Account_Management/presentation/view/widget/update_member_account_dialog.dart';
import 'package:rehana_dashboared/feature/bar_navigation/manger/bar_state.dart';
import '../../../../../core/const/paginationcontrols.dart';
import '../../../../../core/utils/colors/colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../../bar_navigation/manger/bar_cubit.dart';
import '../../manger/person_cubit.dart';

class MembersAccountStatementTablet extends StatelessWidget {
  const MembersAccountStatementTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonCubit, PersonState>(
      builder: (context, state) {
        final personCubit = context.read<PersonCubit>();
        personCubit.getallmemberaccounts(personCubit.currentPage);

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
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      child: Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          HeaderCell(text: S.of(context).name, flex: 2),
                          HeaderCell(text: S.of(context).phone, flex: 2),
                          HeaderCell(text: S.of(context).address, flex: 2),
                          HeaderCell(text: S.of(context).status, flex: 2),
                          HeaderCell(text: S.of(context).villanumber, flex: 2),
                          HeaderCell(text: S.of(context).edit, flex: 3),
                        ],
                      ),
                    ),
                  ),

                  if (state is Allmemberssuccful) ...[
                    SliverList.separated(
                      itemCount: state.personPageSize.items.length,
                      itemBuilder: (context, index) {
                        final items = state.personPageSize.items;
                        final row = items[index];
                        final bgColor = index.isOdd ? const Color(0xFFF6F9ED) : Colors.white;

                        return Container(
                          color: bgColor,
                          child: Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              Expanded(
                                flex: 10, // 2+2+2+2+2
                                child: BlocConsumer<BottomCubit,BottomState>(
  listener: (context,state){
  if(  state is Changevillanumber){
    context.read<BottomCubit>().changefinnaceAndItem(4,5);

  }
  },
                                  builder: (context, state) {
                                    final bottomcubitbottomcubit=context.read<BottomCubit>();


    return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    bottomcubitbottomcubit.changevillanumber(row.villaNumber);
                                  },
                                  child: Container(
                                    color: bgColor,
                                    child: Row(
                                      textDirection: TextDirection.rtl,
                                      children: [
                                        DataCell(text: row.fullName, flex: 2),
                                        DataCell(text: row.phoneNumber, flex: 2),
                                        DataCell(text: row.address, flex: 2),
                                        DataCell(
                                          text: row.isMarried == true
                                              ? S.of(context).married
                                              : S.of(context).single,
                                          flex: 2,
                                        ),
                                        DataCell(text: row.villaNumber.toString(), flex: 2),
                                        // StatusCell خارج التفاعل
                                      ],
                                    ),
                                  ),
                                );
  },
),
                              ),

                              Expanded(
                                flex: 3,
                                child: StatusCell(
                                  accept: S.of(context).edit,
                                  refuse: S.of(context).delete,
                                  onAccept: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => UpdateMemberAccountDialog(
                                        id: row.id.toString(),
                                        phoneNumber: row.phoneNumber,
                                        isMarried: row.isMarried,
                                        address: row.address,
                                        villaNumber: row.villaNumber,
                                        fullName: row.fullName,
                                        date: row.date.toUtc(),
                                      ),
                                    );
                                  },
                                  onReject: () {
                                    personCubit.deleteid(row.id);
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                      const Divider(height: 0, color: Color(0xFFE2E2E2)),
                    ),

                    PaginationControls(
                      currentPage: personCubit.currentPage,
                      totalPages: state.personPageSize.totalPages,
                      onNext: personCubit.nextPage,
                      onPrevious: personCubit.previousPage,
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
