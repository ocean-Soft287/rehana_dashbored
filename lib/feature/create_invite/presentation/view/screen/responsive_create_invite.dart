import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../manger/securityonetime_cubit.dart';
import '../widget/create_invite_mobile.dart';
import '../widget/create_invite_tablet.dart' show CreateInviteTablet;

class ResponsiveCreateInvite extends StatelessWidget {
  const ResponsiveCreateInvite({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController reasonofvisit = TextEditingController();
    TextEditingController numofvilla = TextEditingController();
    TextEditingController numofperson = TextEditingController();

    return LayoutBuilder(
      builder: (context, constraints) {
        return BlocProvider(
          create: (context) => GetIt.instance<SecurityonetimeCubit>()..getvilanumber(),
          child: Builder(
            builder: (context) {
              if (constraints.maxWidth < 600) {
                return CreateInviteMobile(
                  name: name,
                  phone: phone,
                  numvilla: numofvilla,
                  reasonofvisit: reasonofvisit,
                  numofperson: numofperson,
                );
              } else {
                return CreateInviteTablet(
                  name: name,
                  phone: phone,
                  numvilla: numofvilla,
                  reasonofvisit: reasonofvisit,
                  numofperson: numofperson,
                );
              }
            },
          ),
        );
      },
    );
  }
}
