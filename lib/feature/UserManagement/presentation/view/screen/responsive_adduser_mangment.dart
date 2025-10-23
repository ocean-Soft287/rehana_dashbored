import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:rehana_dashboared/l10n/app_localizations.dart';
import '../../manger/user_cubit.dart';
import '../widget/add_usermangment_mobile.dart';
import '../widget/add_usermangment_tablet.dart';
class ResponsiveAdduserMangment extends StatelessWidget {
  const ResponsiveAdduserMangment({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final List<String> jobs = [
     AppLocalizations.of(context)!.admin,
     AppLocalizations.of(context)!.account_manager,
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return constraints.maxWidth < 600
            ? BlocProvider(
          create: (context) =>GetIt.instance<UserCubit>(),
  child: AddUsermangmentMobile(
          name: nameController,
          phone: phoneController,
          email: emailController,
          password: passwordController,
          jobs: jobs,
        ),
)
            : BlocProvider(
          create: (context) =>GetIt.instance<UserCubit>(),
  child: AddUsermangmentTablet(
          name: nameController,
          phone: phoneController,
          email: emailController,
          password: passwordController,
          jobs: jobs,
        ),
);
      },
    );
  }
}
