import 'package:flutter/material.dart';

import '../../utils/appstyle/app_styles.dart';
import '../../utils/colors/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.name, this.onTap, this.colors, this.width, this.textcolor});
final String name;
final void Function()? onTap;
 final Color? colors;
 final Color? textcolor;
 final double ?width;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width:width?? .94*MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color:colors ?? Appcolors.kwhite,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            name,
            style: AppStyles.buttonstyle(context,textcolor??Appcolors.kwhite),
          ),
        ),
      ),
    );
  }
}
