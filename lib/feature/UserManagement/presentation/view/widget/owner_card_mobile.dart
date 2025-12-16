import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rehana_dashboared/core/const/widget/mobile_table/row_item.dart'
    show RowItem;
import 'package:rehana_dashboared/l10n/app_localizations.dart';

import '../../../../../core/const/widget/mobile_table/mobile_button.dart';
import '../../../data/model/owner_model.dart';

class OwnerCardMobile extends StatelessWidget {
  final OwnerModel ownerModel;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final bool isButtons;

  const OwnerCardMobile({
    super.key,
    required this.ownerModel,
    required this.onAccept,
    required this.onReject,
    this.isButtons = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.07),
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
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: ownerModel.pictureUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(height: 12),
            RowItem(label: AppLocalizations.of(context)!.name, value: ownerModel.userName),
            RowItem(label: AppLocalizations.of(context)!.email, value: ownerModel.email),
            RowItem(label: AppLocalizations.of(context)!.villa_number, value: ownerModel.villaNumber.toString()),
            RowItem(label: AppLocalizations.of(context)!.phone, value: ownerModel.phoneNumber),
            const SizedBox(height: 8),
            if (isButtons)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MobileButton(
                    text: AppLocalizations.of(context)!.edit,
                    color: const Color(0xFFB5CC6D),
                    onPressed: onAccept,
                  ),
                  const SizedBox(width: 10),
                  MobileButton(
                    text: AppLocalizations.of(context)!.delete,
                    color: const Color(0xFFE74A3B),
                    onPressed: onReject,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
