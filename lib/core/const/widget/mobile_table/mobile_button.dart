import 'package:flutter/material.dart';

import '../../../utils/font/fonts.dart';

class MobileButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const MobileButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: Fonts.font,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
