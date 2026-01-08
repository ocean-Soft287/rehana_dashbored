import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart'
    show BoxDecoration, Center, Padding, SizedBox, ClipRRect, Icon, Expanded;
import 'package:flutter/material.dart'
    show
        CircularProgressIndicator,
        Colors,
        Divider,
        Material,
        Icons,
        showDialog;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart'
    show
        BuildContext,
        Color,
        Container,
        CustomScrollView,
        Radius,
        Row,
        SliverList,
        SliverToBoxAdapter,
        State,
        StatefulWidget,
        Widget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rehana_dashboared/core/const/widget/table/data_cell.dart'
    show DataCell;
import 'package:rehana_dashboared/core/const/widget/table/headercell.dart'
    show HeaderCell;
import 'package:rehana_dashboared/core/utils/colors/colors.dart' show Appcolors;
import 'package:rehana_dashboared/core/widgets/custom_snack_bar.dart';
import 'package:rehana_dashboared/feature/security_view/presentation/view/widget/security_show_alert_dialoug.dart';
import 'package:rehana_dashboared/feature/security_view/presentation/view/widget/security_view_shimmer.dart';
import 'package:rehana_dashboared/l10n/app_localizations.dart';

import '../../../../../core/const/widget/table/status_cell.dart';
import '../../manger/security_cubit.dart';

class SecurityViewTablet extends StatefulWidget {
  const SecurityViewTablet({super.key});

  @override
  State<SecurityViewTablet> createState() => _SecurityViewTabletState();
}

class _SecurityViewTabletState extends State<SecurityViewTablet> {
  late final SecurityCubit _securityCubit;

  @override
  void initState() {
    super.initState();
    _securityCubit = GetIt.instance<SecurityCubit>();
    // Load data only once when screen first opens
    _securityCubit.getallSecurity();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _securityCubit,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(16),
          child: BlocConsumer<SecurityCubit, SecurityState>(
            buildWhen: (previous, current) => current != previous,
            listener: (context, state) {
              if (state is SecurityUpdate) {
                // Refresh data when update occurs
                _securityCubit.getallSecurity();
              } else if (state is SecurityFailure) {
                showCustomSnackBar(context, state.error);
              }
            },
            builder: (context, state) {
              if (state is SecuritySuccful) {
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Appcolors.kprimary,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                        ),
                        child: Row(
                          children: [
                            HeaderCell(
                              text: AppLocalizations.of(context)!.email,
                              flex: 2,
                            ),
                            HeaderCell(
                              text: AppLocalizations.of(context)!.name,
                              flex: 2,
                            ),
                            HeaderCell(
                              text: AppLocalizations.of(context)!.gate_number,
                              flex: 2,
                            ),
                            HeaderCell(
                              text: AppLocalizations.of(context)!.phone,
                              flex: 2,
                            ),
                            HeaderCell(
                              text: AppLocalizations.of(context)!.image,
                              flex: 2,
                            ),
                            HeaderCell(
                              text: AppLocalizations.of(context)!.action,
                              flex: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverList.separated(
                      itemCount: state.securityguard.length,
                      itemBuilder: (_, index) {
                        final item = state.securityguard[index];
                        final bgColor =
                            index.isOdd
                                ? const Color(0xFFF6F9ED)
                                : Colors.white;

                        return Container(
                          color: bgColor,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              DataCell(text: item.email, flex: 2),
                              DataCell(text: item.userName, flex: 2),
                              DataCell(text: item.gateNumber, flex: 2),
                              DataCell(text: item.phoneNumber, flex: 2),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: CachedNetworkImage(
                                        imageUrl: item.pictureUrl.toString(),
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                        placeholder:
                                            (context, url) => const SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            ),
                                        errorWidget:
                                            (context, url, error) =>
                                                const Icon(Icons.error),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: StatusCell(
                                  accept: AppLocalizations.of(context)!.edit,
                                  refuse: AppLocalizations.of(context)!.delete,
                                  onAccept: () {
                                    showDialog(
                                      context: context,
                                      builder:
                                          (context) => SecurityEditAlertDialog(
                                            securityGuardModel:
                                                state.securityguard[index],
                                          ),
                                    );
                                  },
                                  onReject: () {
                                    _securityCubit.deleteMember(
                                      item.id.toInt(),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder:
                          (_, __) => const Divider(
                            height: 0,
                            color: Color(0xFFE2E2E2),
                          ),
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: 50)),
                  ],
                );
              }
              return const Center(child: SecurityViewTableShimmer());
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Note: We're not disposing the cubit since it's from GetIt (singleton)
    // If you need to reset state when widget disposes, call:
    // _securityCubit.resetState();
    super.dispose();
  }
}
