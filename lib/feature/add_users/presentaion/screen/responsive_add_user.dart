import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/utils/appstyle/size_config.dart';
import '../manger/adduser_cubit.dart';
import '../widget/add_user_mobile.dart';
import '../widget/add_user_tablet.dart';

class ResponsiveAddUser extends StatefulWidget {
  const ResponsiveAddUser({super.key});

  @override
  State<ResponsiveAddUser> createState() => _ResponsiveAddUserState();
}

class _ResponsiveAddUserState extends State<ResponsiveAddUser> {
  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController numoffloors = TextEditingController();
    TextEditingController villanum = TextEditingController();
    TextEditingController villaadress = TextEditingController();
    TextEditingController street = TextEditingController();
    TextEditingController area = TextEditingController();
    TextEditingController villalocation = TextEditingController();
    TextEditingController villaspace = TextEditingController();

    SizeConfig.init(context);
    return BlocProvider(
      create: (context) => GetIt.instance<AdduserCubit>(),
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constrains) {
            if (constrains.maxWidth < 800) {
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
                numOfFloors: numoffloors, villaspace: villaspace,
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
                numOfFloors: numoffloors, villaspace: villaspace,
              );
            }
          },
        ),
      ),
    );
  }
}
