import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../../core/utils/responsive/responsive_builder.dart';
import '../../manger/securityonetime_cubit.dart';
import '../widget/create_invite_mobile.dart';
import '../widget/create_invite_tablet.dart' show CreateInviteTablet;

class ResponsiveCreateInvite extends StatefulWidget {
  const ResponsiveCreateInvite({super.key});

  @override
  State<ResponsiveCreateInvite> createState() => _ResponsiveCreateInviteState();
}

class _ResponsiveCreateInviteState extends State<ResponsiveCreateInvite> with StatePersistenceMixin {
  late SecurityonetimeCubit _securityCubit;

  @override
  void initState() {
    super.initState();
    _securityCubit = GetIt.instance<SecurityonetimeCubit>();
    _securityCubit.getvilanumber();
  }

  @override
  void dispose() {
    _securityCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _securityCubit,
      child: ResponsiveBuilder(
        breakpoint: 600,
        builder: (context, isMobile) {
          final name = getController('name');
          final phone = getController('phone');
          final reasonofvisit = getController('reasonofvisit');
          final numofvilla = getController('numofvilla');
          final numofperson = getController('numofperson');

          if (isMobile) {
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
  }
}
