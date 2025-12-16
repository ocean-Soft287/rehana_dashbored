import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehana_dashboared/feature/UserManagement/presentation/view/widget/owner_card_mobile.dart';
import '../../../../../core/utils/appstyle/app_styles.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../manger/user_cubit.dart';
import 'owner_edit_alert_dialog.dart';

class AllOwnersMobile extends StatelessWidget {
  const AllOwnersMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is GetallmemeberLoading || state is UserInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is Getallmemeberfailure) {
                return Center(child: Text(state.message));
              } else if (state is Getallmemebersuccful) {
                final owners = state.userModel;
                if (owners.isEmpty) {
                  return Center(
                    child: Text(AppLocalizations.of(context)!.no_users_found),
                  );
                }
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          "كل الملاك", // All Owners
                          style: AppStyles.styleLogin(context),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverList.separated(
                        itemCount: owners.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          return OwnerCardMobile(
                            ownerModel:  owners[index],
                            isButtons: true,
                            onAccept: () {
                              showDialog(
                                context: context,
                                builder: (context) => OwnerEditAlertDialog(ownerModel: owners[index]),
                              );
                            },
                            onReject: () {
                              context.read<UserCubit>().deleteOwner(owners[index].id);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
