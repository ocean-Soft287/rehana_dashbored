import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../core/utils/appstyle/size_config.dart';
import '../../../../../core/utils/responsive/responsive_builder.dart';
import '../../manger/auth_cubit.dart';
import '../widget/forgetpass_mobile.dart';
import '../widget/forgetpassword_tablet.dart';

class Responsiveforgetpassword extends StatefulWidget {
  const Responsiveforgetpassword({super.key});

  @override
  State<Responsiveforgetpassword> createState() => _ResponsiveforgetpasswordState();
}

class _ResponsiveforgetpasswordState extends State<Responsiveforgetpassword> {
  late AuthCubit _authCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = GetIt.instance<AuthCubit>();
  }

  @override
  void dispose() {
    _authCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    
    return BlocProvider.value(
      value: _authCubit,
      child: Scaffold(
        body: ResponsiveBuilder(
          builder: (context, isMobile) {
            if (isMobile) {
              return const ForgetpassMobile();
            } else {
              return const ForgetpasswordTablet();
            }
          },
        ),
      ),
    );
  }
}
