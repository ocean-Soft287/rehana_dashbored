import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../../core/utils/appstyle/size_config.dart';
import '../../manger/auth_cubit.dart';
import '../widget/mobile_loginscreen.dart';
import '../widget/tablet_loginscreen.dart';

class ResponsiveLogin extends StatefulWidget {
  const ResponsiveLogin({super.key});

  @override
  State<ResponsiveLogin> createState() => _ResponsiveLoginState();
}

class _ResponsiveLoginState extends State<ResponsiveLogin> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    SizeConfig.init(context);
    return BlocProvider(
      create: (context) => GetIt.instance<AuthCubit>(),
      child: Scaffold(


        body: LayoutBuilder(builder: (context, constrains) {
          if (constrains.maxWidth < 800) {
            return MobileLoginScreen(emailController: emailController,
              passwordController: passwordController,);
          }
          else {
            return TabletLoginScreen(emailController: emailController,
              passwordController: passwordController,);
          }
        }),
      ),
    );
  }
}