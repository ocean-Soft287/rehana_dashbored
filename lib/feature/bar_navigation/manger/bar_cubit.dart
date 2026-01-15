import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehana_dashboared/feature/Account_Management/presentation/view/screen/receipts_responsive.dart'
    show ReceiptsResponsive;
import 'package:rehana_dashboared/feature/add_users/presentaion/screen/responsive_add_security.dart';
import 'package:rehana_dashboared/feature/add_users/presentaion/screen/responsive_add_user.dart';
import 'package:rehana_dashboared/feature/UserManagement/presentation/view/screen/responsive_all_owners.dart';
import 'package:rehana_dashboared/feature/collections/presentation/view/screen/responsive_collections_screen.dart';
import 'package:rehana_dashboared/feature/users_management/presentation/view/screen/responsive_add_user_screen.dart';
import 'package:rehana_dashboared/feature/users_management/presentation/view/screen/responsive_view_users_screen.dart';

import 'package:rehana_dashboared/feature/bar_navigation/manger/bar_state.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/const/widget/expansion_sidebar_item.dart';
import '../../Account_Management/presentation/view/screen/account_mangment_choose.dart';
import '../../Account_Management/presentation/view/screen/create_receipt_bond_for_compound_responsive.dart';
import '../../Account_Management/presentation/view/screen/summarybondbyyear_statement_responsive.dart'
    show SummarybondbyyearStatementResponsive;
import '../../Account_Management/presentation/view/screen/responsive_members_account_statement.dart';
import '../../Account_Management/presentation/view/screen/bulk_disbursement_screen_wrapper.dart';

import '../../security_view/presentation/view/responsive_security_view.dart';
import '../../Chat/presentation/view/screen/responsive_chat.dart';
import '../data/model/menu_entry.dart';

class BottomCubit extends Cubit<BottomState> {
  BottomCubit() : super(const BottomInitial());

  static BottomCubit get(BuildContext context) =>
      BlocProvider.of<BottomCubit>(context);

  int finance = 0;
  int villaNumber = 0;
  int selectedMainIndex = 2;
  int selectedSubIndex = 1;

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
      case 0: // Security
        switch (selectedSubIndex) {
          case 0:
            return const ResponsiveAddSecurity(); // Add security
          case 1:
            return const ResponsiveSecurityView(); // View security
          default:
            return const ResponsiveAddSecurity();
        }
      case 1: // Account Management
        switch (selectedSubIndex) {
          case 0: // Receipt Vouchers
            return finance == 0
                ? ReceiptsResponsive()
                : CreateReceiptBondForCompoundResponsive();
          case 1: // Expenses Management
            return const BulkDisbursementScreenWrapper();
          case 2: // Collections (مقبوضات) - NEW SCREEN
            return const ResponsiveCollectionsScreen();
          case 3: // All Members Statement
            return finance == 0
                ? ResponsiveMembersAccountStatement()
                : SummarybondbyyearStatementResponsive();
          default:
            return const AccountManagementChoose();
        }
      case 2: // Owners
        switch (selectedSubIndex) {
          case 0:
            return const ResponsiveAddUser(); // Add Owner
          case 1:
            return const ResponsiveAllOwners(); // All Owners
          default:
            return const ResponsiveAddUser();
        }
      case 3: // User Management
        switch (selectedSubIndex) {
          case 0:
            return const ResponsiveAddUserScreen(); // Add User
          case 1:
            return const ResponsiveViewUsersScreen(); // View Users
          default:
            return const ResponsiveAddUserScreen();
        }
      case 4: // Chat
        return const ResponsiveChat();
      default:
        return const ResponsiveAddSecurity(); // Default screen
    }
  }

  List<dynamic> menuItems(BuildContext context) => [
    // Owners - Expansion item (Index 2)
    ExpansionMenuEntry("الملاك", Icons.people, [
      SidebarSubItem(
        title: "اضافة مالك",
        icon: Icons.person_add,
        isSelected: selectedMainIndex == 2 && selectedSubIndex == 0,
        onTap: () => changeSubItem(2, 0),
      ),
      SidebarSubItem(
        title: "كل الملاك",
        icon: Icons.people,
        isSelected: selectedMainIndex == 2 && selectedSubIndex == 1,
        onTap: () => changeSubItem(2, 1),
      ),
    ]),
    // Security - Expansion item (Index 0)
    ExpansionMenuEntry(AppLocalizations.of(context)!.security, Icons.security, [
      SidebarSubItem(
        title: AppLocalizations.of(context)!.add_security,
        icon: Icons.add,
        isSelected: selectedMainIndex == 0 && selectedSubIndex == 0,
        onTap: () => changeSubItem(0, 0),
      ),
      SidebarSubItem(
        title: AppLocalizations.of(context)!.view_security,
        icon: Icons.list,
        isSelected: selectedMainIndex == 0 && selectedSubIndex == 1,
        onTap: () => changeSubItem(0, 1),
      ),
    ]),

    // User Management - Expansion item (Index 3)
    ExpansionMenuEntry(
      AppLocalizations.of(context)!.user_management,
      Icons.supervised_user_circle,
      [
        SidebarSubItem(
          title: "إضافة مستخدم",
          icon: Icons.person_add,
          isSelected: selectedMainIndex == 3 && selectedSubIndex == 0,
          onTap: () => changeSubItem(3, 0),
        ),
        SidebarSubItem(
          title: "عرض جميع المستخدمين",
          icon: Icons.people,
          isSelected: selectedMainIndex == 3 && selectedSubIndex == 1,
          onTap: () => changeSubItem(3, 1),
        ),
      ],
    ),

    // Account Management - Expansion item (Index 1)
    ExpansionMenuEntry(
      AppLocalizations.of(context)!.account_management,
      Icons.settings,
      [
        SidebarSubItem(
          title: AppLocalizations.of(context)!.receipt_vouchers,
          icon: Icons.receipt,
          isSelected: selectedMainIndex == 1 && selectedSubIndex == 0,
          onTap: () => changeSubItem(1, 0),
        ),
        SidebarSubItem(
          title: "إدارة المصروفات",
          icon: Icons.account_balance_wallet,
          isSelected: selectedMainIndex == 1 && selectedSubIndex == 1,
          onTap: () => changeSubItem(1, 1),
        ),
        SidebarSubItem(
          title: "مقبوضات",
          icon: Icons.payments,
          isSelected: selectedMainIndex == 1 && selectedSubIndex == 2,
          onTap: () => changeSubItem(1, 2),
        ),
        // SidebarSubItem(
        //   title: AppLocalizations.of(context)!.members_account_statement,
        //   icon: Icons.people_outline,
        //   isSelected: selectedMainIndex == 1 && selectedSubIndex == 3,
        //   onTap: () => changeSubItem(1, 3),
        // ),
      ],
    ),

    // Chat - Simple item (Index 4)
    MenuEntry(AppLocalizations.of(context)!.chat, Icons.chat_bubble_outline),
  ];
}

class ExpansionMenuEntry {
  final String title;
  final IconData icon;
  final List<SidebarSubItem> subItems;

  ExpansionMenuEntry(this.title, this.icon, this.subItems);
}
