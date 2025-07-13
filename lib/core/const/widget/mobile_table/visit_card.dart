import 'package:flutter/material.dart';
import '../../../../feature/Home/data/model/visitinvitation.dart';
import '../../../../generated/l10n.dart';
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.07),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: const Color(0xFFE2E2E2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RowItem(label: S.of(context).villanumber, value: invitation.memberVillaNumber.toString()),
            RowItem(label: S.of(context).name, value: invitation.memberUserName),
            RowItem(
              label: S.of(context).time,
              value: "${invitation.dateFrom.toIso8601String()} - ${invitation.dateTo.toIso8601String()}",
            ),
            RowItem(label: S.of(context).reasonforvisit, value: invitation.reasonForVisit),
            RowItem(label: S.of(context).status, value: invitation.status),
            const SizedBox(height: 8),
            if (isButtons == true)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MobileButton(text: S.of(context).accept, color: const Color(0xFFB5CC6D), onPressed: onAccept),
                  const SizedBox(width: 10),
                  MobileButton(text: S.of(context).refuse, color: const Color(0xFFE74A3B), onPressed: onReject),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
