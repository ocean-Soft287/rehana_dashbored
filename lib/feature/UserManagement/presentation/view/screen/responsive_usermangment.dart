import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rehana_dashboared/core/utils/colors/colors.dart';
import 'package:rehana_dashboared/feature/UserManagement/presentation/view/screen/responsive_adduser_mangment.dart';
import '../../../../../generated/l10n.dart';
import 'package:rehana_dashboared/core/utils/appstyle/app_styles.dart';

import '../../manger/user_cubit.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rehana_dashboared/core/utils/colors/colors.dart';
import 'package:rehana_dashboared/core/utils/appstyle/app_styles.dart';
import 'package:rehana_dashboared/feature/UserManagement/presentation/view/screen/responsive_adduser_mangment.dart';
import '../../../../../generated/l10n.dart';
import '../../manger/user_cubit.dart';

class ResponsiveUserManagement extends StatelessWidget {
  const ResponsiveUserManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (_) => GetIt.instance<UserCubit>()..getallmemeber(),
      child: const _ResponsiveUserManagementView(),
    );
  }
}

class _ResponsiveUserManagementView extends StatelessWidget {
  const _ResponsiveUserManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 700;
    final userCubit = context.read<UserCubit>();

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
              color: CupertinoColors.systemGrey.withOpacity(0.1),
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
                S.of(context).userManagement,
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
                color: Appcolors.greenMember.withOpacity(0.3),
                padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        S.of(context).name,
                        textAlign: TextAlign.center,
                        style: AppStyles.styleLogin(context),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        S.of(context).job,
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
              listener: (context, state) {
                if (state is Addusersuccful) {
                  userCubit.getallmemeber();
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
                userCubit.getallmemeber();

                if (state is Getallmemebersuccful) {
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
                                child: Text(
                                  user.fullName,
                                  textAlign: TextAlign.center,
                                  style: AppStyles.styleRegular16(context),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  user.roles.isNotEmpty
                                      ? user.roles[0]
                                      : '-',
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

                return const SliverToBoxAdapter(
                  child: Center(),
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
