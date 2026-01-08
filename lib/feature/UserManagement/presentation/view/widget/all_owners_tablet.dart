import 'package:flutter/material.dart' hide DataCell;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/const/widget/table/headercell.dart';
import '../../../../../core/const/widget/table/data_cell.dart';
import '../../../../../core/const/widget/table/status_cell.dart';
import '../../../../../core/utils/colors/colors.dart' show Appcolors;
import '../../../../../core/widgets/custom_snack_bar.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../manger/user_cubit.dart';
import 'owner_edit_alert_dialog.dart';
import 'all_owners_table_shimmer.dart';

class AllOwnersTablet extends StatefulWidget {
  const AllOwnersTablet({super.key});

  @override
  State<AllOwnersTablet> createState() => _AllOwnersTabletState();
}

class _AllOwnersTabletState extends State<AllOwnersTablet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(16),
        child: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state is Getallmemeberfailure) {
              showCustomSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is Getallmemebersuccful) {
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
                            text: AppLocalizations.of(context)!.villa_number,
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
                    itemCount: state.userModel.length,
                    itemBuilder: (_, index) {
                      final item = state.userModel[index];
                      print(
                        "http://78.89.159.126:9393/TheOneAPIRehana${item.pictureUrl}",
                      );
                      final bgColor =
                          index.isOdd ? const Color(0xFFF6F9ED) : Colors.white;

                      return Container(
                        color: bgColor,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            DataCell(text: item.email, flex: 2),
                            DataCell(text: item.userName, flex: 2),
                            DataCell(
                              text: item.villaNumber.toString(),
                              flex: 2,
                            ),
                            DataCell(text: item.phoneNumber, flex: 2),
                            Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      "http://78.89.159.126:9393/TheOneAPIRehana${item.pictureUrl}",
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (
                                        context,
                                        child,
                                        loadingProgress,
                                      ) {
                                        if (loadingProgress == null)
                                          return child;
                                        return const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        );
                                      },
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        return const Icon(Icons.error);
                                      },
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
                                        (context) => OwnerEditAlertDialog(
                                          ownerModel: item,
                                        ),
                                  );
                                },
                                onReject: () {
                                  context.read<UserCubit>().deleteOwner(
                                    item.id,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder:
                        (_, __) =>
                            const Divider(height: 0, color: Color(0xFFE2E2E2)),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 50)),
                ],
              );
            }
            return const AllOwnersTableShimmer();
          },
        ),
      ),
    );
  }
}
