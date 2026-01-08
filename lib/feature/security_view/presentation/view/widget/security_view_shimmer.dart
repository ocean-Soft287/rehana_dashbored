import 'package:flutter/material.dart';
import '../../../../../core/widgets/generic_table_shimmer.dart';
import '../../../../../l10n/app_localizations.dart';

class SecurityViewTableShimmer extends StatelessWidget {
  const SecurityViewTableShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GenericTableShimmer(
      columns: [
        TableColumn(
          title: AppLocalizations.of(context)!.email,
          flex: 2,
          shimmerWidth: 140,
        ),
        TableColumn(
          title: AppLocalizations.of(context)!.name,
          flex: 2,
          shimmerWidth: 80,
        ),
        TableColumn(
          title: AppLocalizations.of(context)!.gate_number,
          flex: 2,
          shimmerWidth: 50,
        ),
        TableColumn(
          title: AppLocalizations.of(context)!.phone,
          flex: 2,
          shimmerWidth: 100,
        ),
        TableColumn(
          title: AppLocalizations.of(context)!.image,
          flex: 2,
          type: ColumnType.image,
        ),
        TableColumn(
          title: AppLocalizations.of(context)!.action,
          flex: 2,
          type: ColumnType.buttons,
        ),
      ],
    );
  }
}
