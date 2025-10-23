import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehana_dashboared/feature/bar_navigation/manger/bar_cubit.dart';
import 'package:rehana_dashboared/feature/bar_navigation/manger/bar_state.dart';
import 'package:rehana_dashboared/l10n/app_localizations.dart';
import '../widget/account_card.dart';

class AccountManagementChoose extends StatelessWidget {
  const AccountManagementChoose({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomCubit, BottomState>(
      builder: (context, state) {
        final bottomCubit = BottomCubit.get(context);
        return Center(
          child: Container(
            height: 1.3 * MediaQuery.of(context).size.height,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: CupertinoColors.systemGrey.withValues( alpha:0.1),
                  blurRadius: 12,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: AccountCard(
                        title:AppLocalizations.of(context)!.create_account,
                        color: Colors.white,
                        onTap: () {
                          bottomCubit.changefinnaceAndItem(1, 5);
                        },
                        isFullWidth: true,
                      ),
                    ),
                    const Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                      flex: 2,
                      child: AccountCard(
                        title:AppLocalizations.of(context)!.members_account_statement,
                        color: Colors.white,
                        onTap: () {
                          bottomCubit.changefinnaceAndItem(3,5 );
                        },
                        isFullWidth: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    // Expanded(
                    //   flex: 2,
                    //   child: AccountCard(
                    //     title:AppLocalizations.of(context)!.single_member_account_statement,
                    //     color: Colors.white,
                    //     onTap: () {
                    //       bottomCubit.changefinnaceAndItem(4,5);
                    //
                    //
                    //     },
                    //   ),
                    // ),
                    Expanded(
                      flex: 2,
                      child: AccountCard(
                        title:AppLocalizations.of(context)!.disbursement_bond_for_compound,
                        color: Colors.white,
                        onTap: () {
                          bottomCubit.changefinnaceAndItem(8, 5);

                        },
                      ),
                    ),
                    const Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                      flex: 2,
                      child: AccountCard(
                        title:AppLocalizations.of(context)!.create_voucher,
                        color: Colors.white,
                        onTap: () {
                          bottomCubit.changefinnaceAndItem(2, 5);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: AccountCard(
                        title:AppLocalizations.of(context)!.payment_vouchers,
                        color: Colors.white,
                        onTap: () {
                          bottomCubit.changefinnaceAndItem(6, 5);

                        },
                      ),
                    ),
                    const Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                      flex: 2,
                      child: AccountCard(
                        title:AppLocalizations.of(context)!.receipt_vouchers,
                        color: Colors.white,
                        onTap: () {
                          bottomCubit.changefinnaceAndItem(5, 5);

                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: AccountCard(
                        title:AppLocalizations.of(context)!.create_disbursement_bond_for_compound,
                        color: Colors.white,
                        onTap: () {
                          bottomCubit.changefinnaceAndItem(7, 5);

                        },
                      ),
                    ),
                    const Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                      flex: 2,
                      child: SizedBox()
                    ),
                  ],
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
