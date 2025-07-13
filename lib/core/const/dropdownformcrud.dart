import 'package:flutter/material.dart';
import '../utils/colors/colors.dart';
import '../utils/font/fonts.dart';

class DropdownFormCrud extends StatelessWidget {
  final String name;
  final String hint;
  final List<String> items;
  final String? value;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const DropdownFormCrud({
    super.key,
    required this.name,
    required this.hint,
    required this.items,
    this.value,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontFamily: Fonts.font,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Appcolors.kprimary,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          validator: validator,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            hintText: hint,
            hintStyle: const TextStyle(
              color: Appcolors.kprimary,
              fontFamily: Fonts.font,
            ),
            filled: true,
            fillColor: Appcolors.kwhite,
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFCBCFD7), width: 1.5),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFCBCFD7), width: 1.5),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFCBCFD7), width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Appcolors.kprimary),
          style: const TextStyle(
            color: Appcolors.kprimary,
            fontFamily: Fonts.font,
          ),
          items: items
              .map((e) => DropdownMenuItem<String>(
            value: e,
            child: Text(e,
                style: TextStyle(
                  fontFamily: Fonts.font,
                  color: Appcolors.kprimary,
                )),
          ))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
