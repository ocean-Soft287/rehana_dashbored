import 'dart:ui' as ui;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rehana_dashboared/core/utils/Network/local/cache_manager.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'bloc_observer.dart';
import 'core/utils/Network/local/sharedprefrences.dart';
import 'core/utils/font/fonts.dart';
import 'core/utils/route/approutes.dart';
import 'core/utils/services/services_locator.dart';
import 'feature/create_invite/presentation/manger/securityonetime_cubit.dart';
import 'feature/localization/localizationmodel/localizationmodel.dart';
import 'feature/localization/manger/localization_cubit.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // WidgetsFlutterBinding.ensureInitialized();
  await CacheManager.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  ui.channelBuffers.setListener('flutter/lifecycle', (data, _) {});
  setup();
  await Hive.initFlutter();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) =>
                  LocalizationCubit()
                    ..appLanguage(LanguageEventEnums.initialLanguage),
        ),
        BlocProvider(
          create:
              (_) => GetIt.instance<SecurityonetimeCubit>()..getvilanumber(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: Fonts.font),
        locale: const Locale('ar'),
        supportedLocales: const [Locale('ar')],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        initialRoute: Routes.splash,
        onGenerateRoute: AppRouter.getRoute,
      ),
    );
  }
}

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: -200,
      end: 0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 500), () async {
      final token = await CacheManager.getAccessToken();
      final role = await CacheManager().getData(key: "role");
      // final token = await SecureStorageService.read(SecureStorageService.token);
      // final role = await SecureStorageService.read(SecureStorageService.role);
      final nextRoute =
          (token != null || role != null) ? Routes.home : Routes.login;

      if (mounted) {
        Navigator.pushReplacementNamed(context, nextRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _animation.value),
              child: child,
            );
          },
          child: Image.asset(
            "assets/photo/logo.png",
            width: 268,
            height: 353,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
