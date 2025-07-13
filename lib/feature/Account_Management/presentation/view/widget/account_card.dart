import 'package:flutter/cupertino.dart';

import '../../../../../core/utils/colors/colors.dart';
import '../../../../../core/utils/font/fonts.dart';


class AccountCard extends StatelessWidget {
  const AccountCard({
    super.key,
    required this.title,
    required this.color,
    required this.onTap,
    this.isFullWidth = false,
  });

  final String title;
  final Color color;
  final VoidCallback onTap;
  final bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        width: isFullWidth ? double.infinity : null,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Appcolors.kprimary.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            // الشريط العمودي الأيسر
            Container(
              width: 6,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Appcolors.kprimary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: Fonts.font,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Appcolors.kprimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
