import 'package:flutter/material.dart';

import '../../../feature/Auth/presentation/view/screen/forgetpassword.dart';
import '../../../feature/Auth/presentation/view/screen/login.dart';
import '../../../feature/bar_navigation/presentation/screen/custom_column_slider.dart';
import '../../../main.dart';

import 'package:flutter/material.dart';
import '../../../feature/Auth/presentation/view/screen/forgetpassword.dart';
import '../../../feature/Auth/presentation/view/screen/login.dart';
import '../../../feature/bar_navigation/presentation/screen/custom_column_slider.dart';
import '../../../main.dart';

class Routes {
  static const String login = '/login';
  static const String splash = '/splash';
  static const String home = '/home';
  static const String forgetPassword = '/forget_password';
}

class AppRouter {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const ResponsiveLogin());
      case Routes.forgetPassword:
        return MaterialPageRoute(builder: (_) => const Responsiveforgetpassword());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const SidebarMenu());
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const Splashscreen());
      default:
        return MaterialPageRoute(builder: (_) => const ResponsiveLogin());
    }
  }
}
