import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rehana_dashboared/core/utils/colors/colors.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.staggeredDotsWave(
      color: color ?? Appcolors.bIcon,
      size: 50,
    );
  }
}