import 'package:flutter/material.dart';
import '../../utils/colors/colors.dart';
import '../../utils/font/fonts.dart';

class ExpansionSidebarItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final List<SidebarSubItem> subItems;
  final bool isSelected;
  final VoidCallback? onTap;

  const ExpansionSidebarItem({
    super.key,
    required this.title,
    required this.icon,
    required this.subItems,
    this.isSelected = false,
    this.onTap,
  });

  @override
  State<ExpansionSidebarItem> createState() => _ExpansionSidebarItemState();
}

class _ExpansionSidebarItemState extends State<ExpansionSidebarItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 10,
          selected: widget.isSelected,
          selectedTileColor: widget.isSelected ? Colors.white : Appcolors.kprimary,
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
            widget.onTap?.call();
          },
          title: Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: widget.isSelected ? Appcolors.kprimary1 : Colors.white,
                    fontFamily: Fonts.font,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: widget.isSelected ? Appcolors.kprimary : Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Icon(
                  widget.icon,
                  color: widget.isSelected ? Appcolors.kprimary : Colors.white,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: Column(
              children: widget.subItems.map((subItem) {
                return ListTile(
                  contentPadding: const EdgeInsets.only(right: 16),
                  horizontalTitleGap: 8,
                  selected: subItem.isSelected,
                  selectedTileColor: subItem.isSelected ? Colors.white.withValues(alpha: 0.8) : Colors.transparent,
                  onTap: subItem.onTap,
                  title: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          subItem.title,
                          style: TextStyle(
                            color: subItem.isSelected ? Appcolors.kprimary1 : Colors.white.withValues(alpha: 0.9),
                            fontFamily: Fonts.font,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          subItem.icon,
                          color: subItem.isSelected ? Appcolors.kprimary : Colors.white.withValues(alpha: 0.9),
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}

class SidebarSubItem {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  SidebarSubItem({
    required this.title,
    required this.icon,
    this.isSelected = false,
    required this.onTap,
  });
}