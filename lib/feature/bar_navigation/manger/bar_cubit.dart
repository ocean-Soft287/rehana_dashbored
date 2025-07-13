import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehana_dashboared/feature/Account_Management/presentation/view/screen/receipts_responsive.dart'
    show ReceiptsResponsive;
import 'package:rehana_dashboared/feature/Account_Management/presentation/view/screen/exchangebonds_responsive.dart' show ExchangebondsResponsive;
import 'package:rehana_dashboared/feature/add_users/presentaion/screen/responsive_add_security.dart';
import 'package:rehana_dashboared/feature/add_users/presentaion/screen/responsive_add_user.dart';
import 'package:rehana_dashboared/feature/bar_navigation/manger/bar_state.dart';
import '../../../generated/l10n.dart';
import '../../Account_Management/presentation/view/screen/account_mangment_choose.dart';
import '../../Account_Management/presentation/view/screen/create_receipt_bond_for_compound_responsive.dart';
import '../../Account_Management/presentation/view/screen/summarybondbyyear_statement_responsive.dart'
    show  SummarybondbyyearStatementResponsive;
import '../../Account_Management/presentation/view/screen/responsive_create_abond.dart';
import '../../Account_Management/presentation/view/screen/responsive_members_account_statement.dart';
import '../../Account_Management/presentation/view/screen/responsive_receipt_bond_for_compound.dart';
import '../../Home/presentation/view/screen/responsive_home.dart';
import '../../UserManagement/presentation/view/screen/responsive_usermangment.dart';
import '../../add_users/presentaion/screen/add_account_mangment_responsive.dart';
import '../../create_invite/presentation/view/screen/responsive_create_invite.dart';
import '../../security_view/presentation/view/responsive_security_view.dart';
import '../data/model/menu_entry.dart';


class BottomCubit extends Cubit<BottomState> {
  BottomCubit() : super(const BottomInitial());

  static BottomCubit get(BuildContext context) =>
      BlocProvider.of<BottomCubit>(context);

  int finnance = 0;
int villanumber=0;
  void changeItem(int index) {
    emit(BottomItemSelected(index));
  }

  void changefinnace(int value) {
    finnance = value;
    emit(
      BottomItemSelected(
        state is BottomItemSelected ? (state as BottomItemSelected).index : 0,
      ),
    );
  }

  void changefinnaceAndItem(int value, int index) {
    finnance = value;
    if (state is BottomItemSelected &&
        (state as BottomItemSelected).index == index) {
      emit(const BottomInitial());
    }
    emit(BottomItemSelected(index));
  }
  void changevillanumber(int value){
    villanumber=value;
    emit(Changevillanumber());
  }

  List<Widget> get screens => [
    const ResponsiveHome(),
    ResponsiveCreateInvite(),
    const ResponsiveAddUser(),
    const ResponsiveAddSecurity(),
    const ResponsiveSecurityView(),
    finnance == 0
        ? const AccountManagementChoose()
        : finnance == 1
        ? const AddAccountMangment()
        : finnance == 2
        ? ResponsiveCreateAbond()
        : finnance == 3
        ? ResponsiveMembersAccountStatement()
        : finnance == 4
        ? SummarybondbyyearStatementResponsive()
        : finnance == 5
        ? ReceiptsResponsive()
        :finnance == 6? ExchangebondsResponsive():
  finnance==7?  CreateReceiptBondForCompoundResponsive():
  ResponsiveReceiptBondForCompound(),
    // ExchangeBondsResponsive(),
    const ResponsiveUserManagement(),
    const Placeholder(),
    // const Placeholder(),
  ];

  List<MenuEntry> menuItems(BuildContext context) => [
    MenuEntry(S.of(context).invitations, Icons.groups),
    MenuEntry(S.of(context).create_invitation, Icons.grid_view_rounded),
    MenuEntry(S.of(context).add_mamber, Icons.edit),
    MenuEntry(S.of(context).add_security_guard, Icons.security),
    MenuEntry(S.of(context).security, Icons.lock),

    MenuEntry(S.of(context).accountmanagement, Icons.settings),
    MenuEntry(S.of(context).user_mangment, Icons.supervised_user_circle),
    MenuEntry(S.of(context).chat, Icons.chat_bubble_outline),
  ];
}

