import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rehana_dashboared/feature/Home/presentation/view/screen/tablet_home.dart';

import '../../manger/homeinvitation_cubit.dart';
import 'mobile_home.dart';

class ResponsiveHome extends StatelessWidget {
  const ResponsiveHome({super.key});


  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        return BlocProvider(
          create: (context) => GetIt.instance<HomeinvitationCubit>(),
          child: Builder(
            builder: (context) {
              if (constraints.maxWidth < 600) {
                return MobileHome(
                  key: ValueKey('mobileHome'),
                ); // Unique key
              } else {
                return TabletHome(); // Unique key
              }
            },
          ),
        );
      },
    );
  }
}