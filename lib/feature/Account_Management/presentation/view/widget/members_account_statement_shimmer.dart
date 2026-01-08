import 'package:flutter/material.dart';
import '../../../../../core/widgets/generic_table_shimmer.dart';
import '../../../../../l10n/app_localizations.dart';

class MembersAccountStatementShimmer extends StatelessWidget {
  const MembersAccountStatementShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GenericTableShimmer(
      columns: [
        TableColumn(
          title: AppLocalizations.of(context)!.name,
          flex: 2,
          shimmerWidth: 100,
        ),
        TableColumn(
          title: AppLocalizations.of(context)!.phone,
          flex: 2,
          shimmerWidth: 100,
        ),
        TableColumn(
          title: AppLocalizations.of(context)!.address,
          flex: 2,
          shimmerWidth: 120,
        ),
        TableColumn(
          title: AppLocalizations.of(context)!.status,
          flex: 2,
          shimmerWidth: 60,
        ),
        TableColumn(
          title: AppLocalizations.of(context)!.villa_number,
          flex: 2,
          shimmerWidth: 40,
        ),
        TableColumn(
          title: AppLocalizations.of(context)!.edit,
          flex: 3,
          type: ColumnType.buttons,
        ),
      ],
    );
  }
}
