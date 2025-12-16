import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/appstyle/app_styles.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../manger/user_cubit.dart';

class AllOwnersMobile extends StatelessWidget {
  const AllOwnersMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Text(
            "كل الملاك", // All Owners
            style: AppStyles.styleLogin(context),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
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
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: owners.length,
                  itemBuilder: (context, index) {
                    final owner = owners[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(owner.userName.isNotEmpty
                              ? owner.userName[0].toUpperCase()
                              : "?"),
                        ),
                        title: Text(owner.userName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(owner.phoneNumber),
                            Text(owner.email),
                          ],
                        ),
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
    );
  }
}
