import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rehana_dashboared/feature/security_view/presentation/view/widget/secirtycardmobile.dart';
import 'package:rehana_dashboared/feature/security_view/presentation/view/widget/security_show_alert_dialoug.dart';
import 'package:rehana_dashboared/feature/security_view/presentation/view/widget/security_view_shimmer.dart';
import '../../manger/security_cubit.dart';

class SecurityViewMobile extends StatefulWidget {
  const SecurityViewMobile({super.key});

  @override
  State<SecurityViewMobile> createState() => _SecurityViewMobileState();
}

class _SecurityViewMobileState extends State<SecurityViewMobile> {
  late final SecurityCubit _securityCubit;

  @override
  void initState() {
    super.initState();
    _securityCubit = GetIt.instance<SecurityCubit>();
    _securityCubit.getallSecurity();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _securityCubit,
      child: BlocConsumer<SecurityCubit, SecurityState>(
        listener: (context, state) {
          if (state is SecurityFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          // ❌ REMOVED: securityCubit.getallSecurity(); - No more duplicate calls!
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
                            builder:
                                (context) => SecurityEditAlertDialog(
                                  securityGuardModel: row,
                                ),
                          );
                        },
                        onReject: () {
                          _securityCubit.deleteMember(row.id.toInt());
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return const Center(child: SecurityViewTableShimmer());
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
