import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/utils/appstyle/size_config.dart';
import '../../../../core/utils/responsive/responsive_builder.dart';
import '../manger/adduser_cubit.dart';
import '../widget/add_user_mobile.dart';
import '../widget/add_user_tablet.dart';

class ResponsiveAddUser extends StatefulWidget {
  const ResponsiveAddUser({super.key});

  @override
  State<ResponsiveAddUser> createState() => _ResponsiveAddUserState();
}

class _ResponsiveAddUserState extends State<ResponsiveAddUser> with StatePersistenceMixin {
  late AdduserCubit _adduserCubit;

  @override
  void initState() {
    super.initState();
    _adduserCubit = GetIt.instance<AdduserCubit>();
  }

  @override
  void dispose() {
    _adduserCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    
    return BlocProvider.value(
      value: _adduserCubit,
      child: Scaffold(
        body: ResponsiveBuilder(
          builder: (context, isMobile) {
            final name = getController('name');
            final phone = getController('phone');
            final email = getController('email');
            final password = getController('password');
            final numoffloors = getController('numoffloors');
            final villanum = getController('villanum');
            final villaadress = getController('villaadress');
            final street = getController('street');
            final area = getController('area');
            final villalocation = getController('villalocation');
            final villaspace = getController('villaspace');

            if (isMobile) {
              return AddUserMobile(
                name: name,
                phone: phone,
                email: email,
                password: password,
                street: street,
                area: area,
                villaAddress: villaadress,
                villaNumber: villanum,
                villaLocation: villalocation,
                numOfFloors: numoffloors,
                villaspace: villaspace,
              );
            } else {
              return AddUserTablet(
                name: name,
                phone: phone,
                email: email,
                password: password,
                street: street,
                area: area,
                villaAddress: villaadress,
                villaNumber: villanum,
                villaLocation: villalocation,
                numOfFloors: numoffloors,
                villaspace: villaspace,
              );
            }
          },
        ),
      ),
    );
  }
}
