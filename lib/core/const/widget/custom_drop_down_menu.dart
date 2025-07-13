import 'package:flutter/material.dart';
import '../../utils/colors/colors.dart';
import '../../utils/font/fonts.dart';

class CustomDropdownCrud extends StatelessWidget {
  final String name;
  final String hint;
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String?> onChanged;

  const CustomDropdownCrud({
    super.key,
    required this.name,
    required this.hint,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontFamily: Fonts.font,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Appcolors.kprimary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Appcolors.kwhite,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: DropdownButtonFormField<String>(
            value: selectedItem,
            onChanged: onChanged,
            style: TextStyle( // النص المختار
              fontFamily: Fonts.font,
              color: Appcolors.kprimary,
            ),
            items: items
                .map((item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  fontFamily: Fonts.font,
                  color: Appcolors.kprimary,
                ),
              ),
            ))
                .toList(),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              hintText: hint,
              hintStyle: TextStyle(
                color: Appcolors.kprimary,
                fontFamily: Fonts.font,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFCBCFD7),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFCBCFD7),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFCBCFD7),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
