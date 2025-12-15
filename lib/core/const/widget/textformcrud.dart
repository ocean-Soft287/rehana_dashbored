import 'package:flutter/material.dart';

import '../../utils/colors/colors.dart';
import '../../utils/font/fonts.dart';


class Textformcrud extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  final String nameinfo;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? initialValue; // New optional parameter for initial value

  const Textformcrud({
    super.key,
    required this.controller,
    required this.name,
    required this.nameinfo,
    this.validator,
    this.keyboardType,
    this.initialValue, // Added to constructor
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          name,
          style: TextStyle(
            fontFamily: Fonts.font,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Appcolors.kprimary,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType ?? TextInputType.text,
          initialValue: initialValue, // Set initial value if provided
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            hintText: nameinfo,
            hintStyle: TextStyle(
              color: Appcolors.kprimary,
              fontFamily: Fonts.font,
            ),
            filled: true,
            fillColor: Appcolors.kwhite,
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
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}