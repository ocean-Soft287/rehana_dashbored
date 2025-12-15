import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../../core/utils/appstyle/size_config.dart';
import '../../../../../core/utils/responsive/responsive_builder.dart';
import '../../manger/auth_cubit.dart';
import '../widget/mobile_loginscreen.dart';
import '../widget/tablet_loginscreen.dart';

class ResponsiveLogin extends StatefulWidget {
  const ResponsiveLogin({super.key});

  @override
  State<ResponsiveLogin> createState() => _ResponsiveLoginState();
}

class _ResponsiveLoginState extends State<ResponsiveLogin> with StatePersistenceMixin {
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
            final emailController = getController('email');
            final passwordController = getController('password');
            
            if (isMobile) {
              return MobileLoginScreen(
                emailController: emailController,
                passwordController: passwordController,
              );
            } else {
              return TabletLoginScreen(
                emailController: emailController,
                passwordController: passwordController,
              );
            }
          },
        ),
      ),
    );
  }
}