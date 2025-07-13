import 'package:flutter/material.dart';
import '../../utils/font/fonts.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isLogout;
  final VoidCallback? onTap;

  const MenuItem({
    super.key,
    required this.title,
    required this.icon,
    this.isLogout = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title,
              style: TextStyle(
                           fontFamily: Fonts.font,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isLogout ? Colors.red : Colors.black,
              ),
            ),
            const SizedBox(width: 10),
            Icon(icon, color: isLogout ? Colors.red : Colors.black, size: 24),
          ],
        ),
      ),
    );
  }
}
