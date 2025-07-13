import 'package:flutter/cupertino.dart';
import '../../../utils/font/fonts.dart';

class RowItem extends StatelessWidget {
  final String label;
  final String value;

  const RowItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: Fonts.font,
                color: Color(0xFF717171),
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontFamily: Fonts.font,
                color: Color(0xFF646464),
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
