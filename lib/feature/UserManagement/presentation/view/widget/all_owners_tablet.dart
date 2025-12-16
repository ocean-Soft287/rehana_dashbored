import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/appstyle/app_styles.dart';
import '../../../../../core/utils/colors/colors.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../manger/user_cubit.dart';

class AllOwnersTablet extends StatelessWidget {
  const AllOwnersTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "كل الملاك", // All Owners
            style: AppStyles.styleLogin(context),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.systemGrey.withValues(alpha: 0.1),
                    blurRadius: 12,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Appcolors.greenMember.withValues(alpha: 0.3),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            AppLocalizations.of(context)!.name,
                            style: AppStyles.styleLogin(context),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            AppLocalizations.of(context)!.phone,
                            style: AppStyles.styleLogin(context),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            AppLocalizations.of(context)!.email,
                            style: AppStyles.styleLogin(context),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'رقم الفيلا',
                            style: AppStyles.styleLogin(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // List
                  Expanded(
                    child: BlocBuilder<UserCubit, UserState>(
                      builder: (context, state) {
                        if (state is GetallmemeberLoading ||
                            state is UserInitial) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is Getallmemeberfailure) {
                          return Center(child: Text(state.message));
                        } else if (state is Getallmemebersuccful) {
                          final owners = state.userModel;
                          if (owners.isEmpty) {
                            return Center(
                              child: Text(
                                AppLocalizations.of(context)!.no_users_found,
                              ),
                            );
                          }
                          return ListView.separated(
                            padding: const EdgeInsets.all(16),
                            itemCount: owners.length,
                            separatorBuilder:
                                (context, index) => const Divider(height: 1),
                            itemBuilder: (context, index) {
                              final owner = owners[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        owner.userName,
                                        style: AppStyles.styleRegular16(
                                          context,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        owner.phoneNumber,
                                        style: AppStyles.styleRegular16(
                                          context,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        owner.email,
                                        style: AppStyles.styleRegular16(
                                          context,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        owner.villaNumber.toString(),
                                        style: AppStyles.styleRegular16(
                                          context,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
