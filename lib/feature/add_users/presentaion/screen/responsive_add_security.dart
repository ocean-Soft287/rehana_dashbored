import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rehana_dashboared/feature/add_users/presentaion/widget/add_security_tablet.dart';

import '../../../../core/utils/appstyle/size_config.dart';
import '../../../../core/utils/responsive/responsive_builder.dart';
import '../manger/adduser_cubit.dart';
import '../widget/add_security_mobile.dart';

class ResponsiveAddSecurity extends StatefulWidget {
  const ResponsiveAddSecurity({super.key});

  @override
  State<ResponsiveAddSecurity> createState() => _ResponsiveAddSecurityState();
}

class _ResponsiveAddSecurityState extends State<ResponsiveAddSecurity> with StatePersistenceMixin {
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
            final numofGate = getController('numofGate');

            if (isMobile) {
              return AddSecurityMobile(
                name: name,
                phone: phone,
                email: email,
                password: password,
                numofgate: numofGate,
              );
            } else {
              return AddSecurityTablet(
                name: name,
                phone: phone,
                email: email,
                password: password,
                numofgate: numofGate,
              );
            }
          },
        ),
      ),
    );
  }
}
