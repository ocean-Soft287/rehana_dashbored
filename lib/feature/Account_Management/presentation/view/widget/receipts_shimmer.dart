import 'package:flutter/material.dart';
import '../../../../../core/widgets/generic_table_shimmer.dart';
import '../../../../../l10n/app_localizations.dart';

class ReceiptsTableShimmer extends StatelessWidget {
  const ReceiptsTableShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GenericTableShimmer(
      columns: [
        TableColumn(
          title: AppLocalizations.of(context)!.voucher_date,
          flex: 2,
          shimmerWidth: 90,
        ),
        TableColumn(
          title: AppLocalizations.of(context)!.currency,
          flex: 1,
          shimmerWidth: 50,
        ),
        TableColumn(
          title: AppLocalizations.of(context)!.creditor,
          flex: 1,
          shimmerWidth: 80,
        ),
        TableColumn(
          title: AppLocalizations.of(context)!.account_num,
          flex: 1,
          shimmerWidth: 70,
        ),
        TableColumn(
          title: AppLocalizations.of(context)!.villa_number,
          flex: 1,
          shimmerWidth: 40,
        ),
        TableColumn(
          title: AppLocalizations.of(context)!.description,
          flex: 1,
          shimmerWidth: 120,
        ),
        TableColumn(
          title: AppLocalizations.of(context)!.type,
          flex: 1,
          shimmerWidth: 60,
        ),
      ],
      showActionButtons: false,
    );
  }
}
