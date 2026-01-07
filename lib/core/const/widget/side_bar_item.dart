import 'package:flutter/material.dart';

import '../../utils/colors/colors.dart';
import '../../utils/font/fonts.dart';

class SidebarItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const SidebarItem({
    super.key,
    required this.title,
    required this.icon,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 10,
      selected: isSelected,
      selectedTileColor: isSelected?Colors.white:Appcolors.kprimary,
      onTap: onTap,
      title: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title,
              style: TextStyle(
    
                color:isSelected?Appcolors.kprimary1: Colors.white,
                fontFamily: TextStyle(
                fontFamily: Fonts.font,).fontFamily,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
    
            const SizedBox(width: 12),
            Icon(icon, color:isSelected?Appcolors.kprimary :Colors.white),
    
          ],
        ),
      ),
    );
  }
}