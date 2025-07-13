import 'package:flutter/cupertino.dart';

import '../../../utils/font/fonts.dart';

class DataCell extends StatelessWidget {
  final String text;
  final int flex;

  const DataCell({super.key, required this.text, this.flex = 1});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: Fonts.font,
              color: Color(0xFF646464),
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
//class DataCell extends StatelessWidget {
//   final String text;
//   final int flex;
//   final bool useExpanded;
//
//   const DataCell({
//     super.key,
//     required this.text,
//     this.flex = 1,
//     this.useExpanded = true,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     Widget child = Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(text),
//     );
//     return useExpanded
//         ? Expanded(flex: flex, child: child)
//         : child;
//   }
// }