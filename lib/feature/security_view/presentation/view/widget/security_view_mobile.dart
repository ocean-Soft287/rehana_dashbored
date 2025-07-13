import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rehana_dashboared/feature/security_view/presentation/view/widget/secirtycardmobile.dart';
import 'package:rehana_dashboared/feature/security_view/presentation/view/widget/security_show_alert_dialoug.dart';

import '../../manger/security_cubit.dart';



class SecurityViewMobile extends StatelessWidget {
  const SecurityViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<SecurityCubit>()..getallSecurity(),
      child: BlocConsumer<SecurityCubit, SecurityState>(
        listener: (context, state) {
          if (state is SecurityFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          final securityCubit = context.read<SecurityCubit>();
          securityCubit.getallSecurity();
          if (state is SecuritySuccful) {

            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList.separated(
                    itemCount: state.securityguard.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final row = state.securityguard[index];
                      return SecurityCardMobile(
                        isButtons: true,
                        securityGuardModel: row,
                        onAccept: () {
                          showDialog(
                            context: context,
                            builder: (context) => SecurityEditAlertDialog(securityGuardModel: row),
                          );
                        },
                        onReject: () {
                          securityCubit.deleteMember(row.id.toInt());
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
