import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rehana_dashboared/core/utils/colors/colors.dart';
import 'package:rehana_dashboared/feature/UserManagement/presentation/view/screen/responsive_adduser_mangment.dart';
import 'package:rehana_dashboared/l10n/app_localizations.dart';
import 'package:rehana_dashboared/core/utils/appstyle/app_styles.dart';

import '../../manger/user_cubit.dart';

class ResponsiveUserManagement extends StatelessWidget {
  const ResponsiveUserManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (_) => GetIt.instance<UserCubit>()..getAllOwners(),
      child: const _ResponsiveUserManagementView(),
    );
  }
}

class _ResponsiveUserManagementView extends StatefulWidget {
  const _ResponsiveUserManagementView();

  @override
  State<_ResponsiveUserManagementView> createState() => _ResponsiveUserManagementViewState();
}

class _ResponsiveUserManagementViewState extends State<_ResponsiveUserManagementView> {
  late final UserCubit _userCubit;

  @override
  void initState() {
    super.initState();
    _userCubit = context.read<UserCubit>();
    // Data is already loaded in BlocProvider.create, so no need to call again
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 700;

    return Scaffold(
      floatingActionButton: isMobile
          ? FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Appcolors.bIcon,
            builder: (context) => Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.all(16),
                child: const ResponsiveAdduserMangment(),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      )
          : null,
      backgroundColor: Colors.grey[50],
      body: Container(
        constraints: BoxConstraints(maxWidth: width),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
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
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              floating: false,
              snap: false,
              backgroundColor: Colors.white,
              title: Text(
                AppLocalizations.of(context)!.user_management,
                style: AppStyles.styleLogin(context),
              ),
            ),
            if (!isMobile)
              SliverToBoxAdapter(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  padding: const EdgeInsets.all(8),
                  child: const ResponsiveAdduserMangment(),
                ),
              ),
            SliverToBoxAdapter(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1000),
                color: Appcolors.greenMember.withValues( alpha:0.3),
                padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        AppLocalizations.of(context)!.name,
                        textAlign: TextAlign.center,
                        style: AppStyles.styleLogin(context),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        AppLocalizations.of(context)!.job,
                        textAlign: TextAlign.center,
                        style: AppStyles.styleLogin(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            BlocConsumer<UserCubit, UserState>(
              buildWhen: (previous, current) => current != previous,
              listener: (context, state) {
                if (state is Addusersuccful) {
                  _userCubit.getAllMembers(); // Refresh list after adding user
                } else if (state is Adduserfailure ||
                    state is Getallmemeberfailure) {
                  final errorMessage = (state as dynamic).message;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(errorMessage),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {

                if (state is GetAllUsersSuccessState) {
                  final users = state.userModel;
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final user = users[index];
                        return Container(
                          constraints: const BoxConstraints(maxWidth: 1000),
                          margin: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: SelectableText(
                                  user.fullName,
                                  textAlign: TextAlign.center,
                                  style: AppStyles.styleRegular16(context),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: SelectableText(
                                  user.roles.toString(),
                                  textAlign: TextAlign.center,
                                  style:
                                  AppStyles.textformfieldstyle(context),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: users.length,
                    ),
                  );
                }

                // Handle loading state
                if (state is GetallmemeberLoading || state is UserInitial) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                // Handle empty state
                if (state is Getallmemebersuccful && state.userModel.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(AppLocalizations.of(context)!.no_users_found),
                    ),
                  );
                }

                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 50)),
          ],
        ),
      ),
    );
  }
}