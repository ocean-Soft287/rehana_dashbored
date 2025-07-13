import 'package:flutter/cupertino.dart';
import 'package:rehana_dashboared/feature/security_view/presentation/view/widget/security_view_mobile.dart';
import 'package:rehana_dashboared/feature/security_view/presentation/view/widget/security_view_tablet.dart';

import 'package:flutter/material.dart';


class ResponsiveSecurityView extends StatelessWidget {
  const ResponsiveSecurityView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        if (constraints.maxWidth < 600) {
          return const SecurityViewMobile(
            key: ValueKey('mobileHome'),

          );
        } else {
          return const SecurityViewTablet(
            key: ValueKey('mobileHome'),

          );
        }
      },
    );
  }
}
