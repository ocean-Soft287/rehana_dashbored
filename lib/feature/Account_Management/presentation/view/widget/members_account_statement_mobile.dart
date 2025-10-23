import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehana_dashboared/core/const/widget/mobile_table/row_item.dart'
    show RowItem;
import 'package:rehana_dashboared/feature/Account_Management/presentation/manger/person_cubit.dart';
import 'package:rehana_dashboared/feature/Account_Management/presentation/view/widget/update_member_account_dialog.dart';

import '../../../../../core/const/paginationcontrols.dart';
import '../../../../../core/const/widget/mobile_table/mobile_button.dart';
import 'package:rehana_dashboared/l10n/app_localizations.dart';
import '../../../../bar_navigation/manger/bar_cubit.dart';
import '../../../../bar_navigation/manger/bar_state.dart';

class MembersAccountStatementMobile extends StatelessWidget {
  const MembersAccountStatementMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonCubit, PersonState>(
      builder: (context, state) {
        final personCubit = context.read<PersonCubit>();
        personCubit.getallmemberaccounts(personCubit.currentPage);
        if (state is Allmemberssuccful) {
          final items = state.personPageSize.items;

          return CustomScrollView(
            slivers: [
              SliverList.separated(
                itemCount: items.length,
                separatorBuilder:
                    (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final row = items[index];
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
                      child: BlocConsumer<BottomCubit, BottomState>(
                        listener: (context, state) {
                          if (state is Changevillanumber) {
                            context.read<BottomCubit>().changefinnaceAndItem(
                              4,
                              5,
                            );
                          }
                        },
                        builder: (context, state) {
                          final bottomcubitbottomcubit =
                              context.read<BottomCubit>();

                          return GestureDetector(
                            onTap: () {
                              bottomcubitbottomcubit.changevillanumber(
                                row.villaNumber,
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                RowItem(
                                  label:AppLocalizations.of(context)!.name,
                                  value: row.fullName.toString(),
                                ),
                                RowItem(
                                  label:AppLocalizations.of(context)!.phone,
                                  value: row.phoneNumber.toString(),
                                ),
                                RowItem(
                                  label:AppLocalizations.of(context)!.address,
                                  value: row.address.toString(),
                                ),
                                RowItem(
                                  label:AppLocalizations.of(context)!.status,
                                  value:
                                      row.isMarried == true
                                          ?AppLocalizations.of(context)!.married
                                          :AppLocalizations.of(context)!.single,
                                ),
                                RowItem(
                                  label:AppLocalizations.of(context)!.villa_number,
                                  value: row.villaNumber.toString(),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MobileButton(
                                      text:AppLocalizations.of(context)!.edit,
                                      color: const Color(0xFFB5CC6D),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder:
                                              (
                                                context,
                                              ) => UpdateMemberAccountDialog(
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
                                    ),
                                    const SizedBox(width: 10),
                                    MobileButton(
                                      text:AppLocalizations.of(context)!.delete,
                                      color: const Color(0xFFE74A3B),
                                      onPressed: () {
                                        personCubit.deleteid(row.id);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              PaginationControls(
                currentPage: personCubit.currentPage,
                totalPages: state.personPageSize.totalPages,
                onNext: () {
                  personCubit.nextPage();
                  personCubit.getallmemberaccounts(personCubit.currentPage);
                },
                onPrevious: () {
                  personCubit.previousPage();
                  personCubit.getallmemberaccounts(personCubit.currentPage);
                },
              ),
            ],
          );
        }

        return const Center();
      },
    );
  }
}
