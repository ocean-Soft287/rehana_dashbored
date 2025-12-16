import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehana_dashboared/feature/Account_Management/presentation/view/screen/receipts_responsive.dart'
    show ReceiptsResponsive;
import 'package:rehana_dashboared/feature/Account_Management/presentation/view/screen/exchangebonds_responsive.dart'
    show ExchangebondsResponsive;
import 'package:rehana_dashboared/feature/add_users/presentaion/screen/responsive_add_security.dart';
import 'package:rehana_dashboared/feature/add_users/presentaion/screen/responsive_add_user.dart';
import 'package:rehana_dashboared/feature/UserManagement/presentation/view/screen/responsive_all_owners.dart';

import 'package:rehana_dashboared/feature/bar_navigation/manger/bar_state.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/const/widget/expansion_sidebar_item.dart';
import '../../Account_Management/presentation/view/screen/account_mangment_choose.dart';
import '../../Account_Management/presentation/view/screen/create_receipt_bond_for_compound_responsive.dart';
import '../../Account_Management/presentation/view/screen/summarybondbyyear_statement_responsive.dart'
    show SummarybondbyyearStatementResponsive;
import '../../Account_Management/presentation/view/screen/responsive_create_abond.dart';
import '../../Account_Management/presentation/view/screen/responsive_members_account_statement.dart';

import '../../Home/presentation/view/widget/screen/responsive_home.dart';
import '../../UserManagement/presentation/view/screen/responsive_usermangment.dart';
import '../../add_users/presentaion/screen/add_account_mangment_responsive.dart';
import '../../create_invite/presentation/view/screen/responsive_create_invite.dart';
import '../../security_view/presentation/view/responsive_security_view.dart';
import '../../Chat/presentation/view/screen/responsive_chat.dart';
import '../data/model/menu_entry.dart';

class BottomCubit extends Cubit<BottomState> {
  BottomCubit() : super(const BottomInitial());

  static BottomCubit get(BuildContext context) =>
      BlocProvider.of<BottomCubit>(context);

  int finance = 0;
  int villaNumber = 0;
  int selectedMainIndex = 0;
  int selectedSubIndex = 0;

  void changeItem(int index) {
    selectedMainIndex = index;
    selectedSubIndex = 0;
    emit(BottomItemSelected(index));
  }

  void changeSubItem(int mainIndex, int subIndex) {
    selectedMainIndex = mainIndex;
    selectedSubIndex = subIndex;
    emit(BottomSubItemSelected(mainIndex, subIndex));
  }

  void changeFinance(int value) {
    finance = value;
    emit(
      BottomItemSelected(
        state is BottomItemSelected ? (state as BottomItemSelected).index : 0,
      ),
    );
  }

  void changeFinanceAndItem(int value, int index) {
    finance = value;
    if (state is BottomItemSelected &&
        (state as BottomItemSelected).index == index) {
      emit(const BottomInitial());
    }
    emit(BottomItemSelected(index));
  }

  // Legacy method names for backward compatibility
  void changefinnaceAndItem(int value, int index) {
    changeFinanceAndItem(value, index);
  }

  void changevillanumber(int value) {
    changeVillaNumber(value);
  }

  // Getter for backward compatibility
  int get villa_number => villaNumber;

  void changeVillaNumber(int value) {
    villaNumber = value;
    emit(Changevillanumber());
  }

  Widget get currentScreen {
    switch (selectedMainIndex) {
      case 0: // Invitations (Previously 1)
        switch (selectedSubIndex) {
          case 0:
            return ResponsiveCreateInvite(); // Add invitation
          case 1:
            return const ResponsiveHome(); // View invitations (placeholder, default)
          default:
            return ResponsiveHome();
        }
      case 1: // Security (Previously 2)
        switch (selectedSubIndex) {
          case 0:
            return const ResponsiveAddSecurity(); // Add security
          case 1:
            return const ResponsiveSecurityView(); // View security
          default:
            return const ResponsiveAddSecurity();
        }
      case 2: // Account Management (Previously 3)
        switch (selectedSubIndex) {
          case 0: // Payment Vouchers
            return finance == 0
                ? ExchangebondsResponsive()
                : ResponsiveCreateAbond();
          case 1: // Receipt Vouchers
            return finance == 0
                ? ReceiptsResponsive()
                : CreateReceiptBondForCompoundResponsive();
          case 2: // Create Account
            return finance == 0
                ? const AddAccountMangment()
                : ResponsiveCreateAbond();
          case 3: // All Members Statement
            return finance == 0
                ? ResponsiveMembersAccountStatement()
                : SummarybondbyyearStatementResponsive();
          default:
            return const AccountManagementChoose();
        }
      case 3: // Add Owner (Previously 4)
        return const ResponsiveAddUser();
      case 4: // All Owners (New)
        return const ResponsiveAllOwners();
      case 5: // User Management
        return const ResponsiveUserManagement();
      case 6: // Chat
        return const ResponsiveChat();
      default:
        return ResponsiveCreateInvite(); // Default screen
    }
  }

  List<dynamic> menuItems(BuildContext context) => [
    // Invitations - Expansion item (Index 0)
    ExpansionMenuEntry(
      AppLocalizations.of(context)!.invitations,
      Icons.groups,
      [
        SidebarSubItem(
          title: AppLocalizations.of(context)!.add_invitation,
          icon: Icons.add,
          isSelected: selectedMainIndex == 0 && selectedSubIndex == 0,
          onTap: () => changeSubItem(0, 0),
        ),
        SidebarSubItem(
          title: AppLocalizations.of(context)!.view_invitations,
          icon: Icons.list,
          isSelected: selectedMainIndex == 0 && selectedSubIndex == 1,
          onTap: () => changeSubItem(0, 1),
        ),
      ],
    ),

    // Security - Expansion item (Index 1)
    ExpansionMenuEntry(AppLocalizations.of(context)!.security, Icons.security, [
      SidebarSubItem(
        title: AppLocalizations.of(context)!.add_security,
        icon: Icons.add,
        isSelected: selectedMainIndex == 1 && selectedSubIndex == 0,
        onTap: () => changeSubItem(1, 0),
      ),
      SidebarSubItem(
        title: AppLocalizations.of(context)!.view_security,
        icon: Icons.list,
        isSelected: selectedMainIndex == 1 && selectedSubIndex == 1,
        onTap: () => changeSubItem(1, 1),
      ),
    ]),

    // Account Management - Expansion item (Index 2)
    ExpansionMenuEntry(
      AppLocalizations.of(context)!.account_management,
      Icons.settings,
      [
        SidebarSubItem(
          title: AppLocalizations.of(context)!.payment_vouchers,
          icon: Icons.receipt_long,
          isSelected: selectedMainIndex == 2 && selectedSubIndex == 0,
          onTap: () => changeSubItem(2, 0),
        ),
        SidebarSubItem(
          title: AppLocalizations.of(context)!.receipt_vouchers,
          icon: Icons.receipt,
          isSelected: selectedMainIndex == 2 && selectedSubIndex == 1,
          onTap: () => changeSubItem(2, 1),
        ),
        SidebarSubItem(
          title: AppLocalizations.of(context)!.create_account,
          icon: Icons.account_circle_outlined,
          isSelected: selectedMainIndex == 2 && selectedSubIndex == 2,
          onTap: () => changeSubItem(2, 2),
        ),
        SidebarSubItem(
          title: AppLocalizations.of(context)!.members_account_statement,
          icon: Icons.people_outline,
          isSelected: selectedMainIndex == 2 && selectedSubIndex == 3,
          onTap: () => changeSubItem(2, 3),
        ),
      ],
    ),

    // Add Owner - Simple item (Index 3)
    MenuEntry(
      "اضافة مالك",
      Icons.person_add,
    ),

    // All Owners - Simple item (Index 4)
    MenuEntry(
      "كل الملاك",
      Icons.people,
    ),

    // User Management - Simple item (Index 5)
    MenuEntry(
      AppLocalizations.of(context)!.user_management,
      Icons.supervised_user_circle,
    ),

    // Chat - Simple item (Index 6)
    MenuEntry(AppLocalizations.of(context)!.chat, Icons.chat_bubble_outline),
  ];
}

class ExpansionMenuEntry {
  final String title;
  final IconData icon;
  final List<SidebarSubItem> subItems;

  ExpansionMenuEntry(this.title, this.icon, this.subItems);
}
