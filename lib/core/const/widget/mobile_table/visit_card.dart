import 'package:flutter/material.dart';
import 'package:rehana_dashboared/core/utils/colors/colors.dart';
import '../../../../feature/Home/data/model/visitinvitation.dart';
import '../../../../l10n/app_localizations.dart';
import 'row_item.dart';
import 'mobile_button.dart';
class VisitCard extends StatelessWidget {
  final VisitInvitation invitation;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final bool? isButtons;

  const VisitCard({
    super.key,
    required this.invitation,
    required this.onAccept,
    required this.onReject,
    this.isButtons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.07),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Appcolors.black, ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RowItem(label:AppLocalizations.of(context)!.villa_number, value: invitation.memberVillaNumber.toString()),
          RowItem(label:AppLocalizations.of(context)!.name, value: invitation.memberUserName),
          RowItem(
            label:AppLocalizations.of(context)!.time,
            value: "${invitation.dateFrom.toIso8601String()} - ${invitation.dateTo.toIso8601String()}",
          ),
          RowItem(label:AppLocalizations.of(context)!.reason_for_visit, value: invitation.reasonForVisit),
          RowItem(label:AppLocalizations.of(context)!.status, value: invitation.status),
          const SizedBox(height: 8),
          if (isButtons == true)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MobileButton(text:AppLocalizations.of(context)!.accept, color: const Color(0xFFB5CC6D), onPressed: onAccept),
                const SizedBox(width: 10),
                MobileButton(text:AppLocalizations.of(context)!.refuse, color: const Color(0xFFE74A3B), onPressed: onReject),
              ],
            ),
        ],
      ),
    );
  }
}
