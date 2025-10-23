import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../utils/font/fonts.dart';
class StatusCell extends StatelessWidget {
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final String? accept;
  final String? refuse;

  const StatusCell({
    super.key,
    required this.onAccept,
    required this.onReject,
    this.accept,
    this.refuse,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFB5CC6D),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            elevation: 0,
          ),
          onPressed: onAccept,
          child: Text(
            accept ??AppLocalizations.of(context)!.accept,
            style: TextStyle(
              fontFamily: Fonts.font,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE74A3B),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            elevation: 0,
          ),
          onPressed: onReject,
          child: Text(
            refuse ??AppLocalizations.of(context)!.refuse,
            style: TextStyle(
              fontFamily: Fonts.font,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
