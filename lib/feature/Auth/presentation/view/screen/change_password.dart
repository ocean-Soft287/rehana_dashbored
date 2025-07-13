import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../core/utils/appstyle/size_config.dart';
import '../../manger/auth_cubit.dart';
import '../widget/change_password_mobile.dart';
import '../widget/change_password_tablet.dart';



class Responsivechangepassword extends StatelessWidget {
  const Responsivechangepassword({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return BlocProvider(
      create: (context) => GetIt.instance<AuthCubit>(),
      child: Scaffold(


        body: LayoutBuilder(builder: (context, constrains) {
          if (constrains.maxWidth < 800) {
            return ChangePasswordMobile();
          }

          else {
            return ConfirmResetPasswordTablet();
          }
        }),
      ),
    );
  }
}
