import 'package:flutter/cupertino.dart';
import 'package:rehana_dashboared/core/utils/colors/colors.dart';
import '../../../utils/font/fonts.dart';

class HeaderCell extends StatelessWidget {
  final String text;
  final int flex;

  const HeaderCell({super.key, required this.text, this.flex = 1});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
        child: Center(
          child: Text(
            text,
            style:  TextStyle(
              fontFamily: Fonts.font,
              color: Appcolors.kwhite,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

