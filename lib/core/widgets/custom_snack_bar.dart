import 'package:flutter/material.dart';
import '../utils/colors/colors.dart';
import '../utils/font/fonts.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void showCustomSnackBar(BuildContext context, String text) {
  final messenger = ScaffoldMessenger.maybeOf(context) ?? scaffoldMessengerKey.currentState;
  messenger?.showSnackBar(
    SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: Fonts.font,
          color: Colors.white,
        ),
      ),
      backgroundColor: Appcolors.kprimary,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      showCloseIcon: true,
    ),
  );
}
