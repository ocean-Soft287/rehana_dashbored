import 'package:flutter/cupertino.dart' show BoxDecoration, Center, Padding, SizedBox, ClipRRect, Icon, Expanded;
import 'package:flutter/material.dart' show CircularProgressIndicator, Colors, Divider, Material, Icons, showDialog, ScaffoldMessenger, Text, SnackBar;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart' show BuildContext, Color, Container, CustomScrollView, Radius, Row, SliverList, SliverToBoxAdapter, StatelessWidget, Widget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rehana_dashboared/core/const/widget/table/headercell.dart' show HeaderCell;
import 'package:rehana_dashboared/core/const/widget/table/data_cell.dart' show DataCell;
import 'package:rehana_dashboared/core/utils/colors/colors.dart' show Appcolors;
import 'package:rehana_dashboared/feature/security_view/presentation/view/widget/security_show_alert_dialoug.dart';
import '../../../../../core/const/widget/table/status_cell.dart';
import '../../../../../generated/l10n.dart';
import '../../manger/security_cubit.dart';


class SecurityViewTablet extends StatelessWidget {
  const SecurityViewTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<SecurityCubit>()..getallSecurity(),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(16),
          child: BlocConsumer<SecurityCubit, SecurityState>(
            listener: (context, state) {
              if (state is SecurityUpdate) {
                final cubit = BlocProvider.of<SecurityCubit>(context);
                cubit.getallSecurity();
              } else if (state is SecurityFailure) {
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
                            HeaderCell(text: S.of(context).email, flex: 2),
                            HeaderCell(text: S.of(context).name, flex: 2),
                            HeaderCell(text: S.of(context).gatenumber, flex: 2),
                            HeaderCell(text: S.of(context).phone, flex: 2),
                            HeaderCell(text: S.of(context).image, flex: 2),
                            HeaderCell(text: S.of(context).action, flex: 2),
                          ],
                        ),
                      ),
                    ),
                    SliverList.separated(
                      itemCount: state.securityguard.length,
                      itemBuilder: (_, index) {
                        final item = state.securityguard[index];
                        final bgColor = index.isOdd ? const Color(0xFFF6F9ED) : Colors.white;

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
                                        placeholder: (context, url) => const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(strokeWidth: 2),
                                        ),
                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: StatusCell(
                                  accept: S.of(context).edit,
                                  refuse: S.of(context).delete,
                                  onAccept: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => SecurityEditAlertDialog(
                                        securityGuardModel: state.securityguard[index],
                                      ),
                                    );
                                  },
                                  onReject: () {
                                    securityCubit.deleteMember(item.id.toInt());
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => const Divider(
                        height: 0,
                        color: Color(0xFFE2E2E2),
                      ),
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: 50)),
                  ],
                );
              }
              return const Center(); // Fallback for other states
            },
          ),
        ),
      ),
    );
  }
}