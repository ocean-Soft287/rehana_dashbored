import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rehana_dashboared/feature/add_users/presentaion/widget/add_security_tablet.dart';

import '../../../../core/utils/appstyle/size_config.dart';
import '../manger/adduser_cubit.dart';
import '../widget/add_security_mobile.dart';


class ResponsiveAddSecurity extends StatelessWidget {
  const ResponsiveAddSecurity({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController numofGate = TextEditingController();


    SizeConfig.init(context);
    return BlocProvider(
      create: (context) => GetIt.instance<AdduserCubit>(),
  child: Scaffold(
      body: LayoutBuilder(
        builder: (context, constrains) {
          if (constrains.maxWidth  < 800) {
       return AddSecurityMobile(name: name, phone: phone, email: email, password: password, numofgate: numofGate);
          } else {
            return AddSecurityTablet(name: name, phone: phone, email: email, password: password, numofgate: numofGate);

          }
        },
      ),
    ),
);  }
}
