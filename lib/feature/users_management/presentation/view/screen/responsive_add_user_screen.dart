import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../../core/utils/responsive/responsive_builder.dart';
import '../../manger/users_management_cubit.dart';
import '../widgets/mobile_add_user_screen.dart';
import '../widgets/tablet_add_user_screen.dart';

class ResponsiveAddUserScreen extends StatefulWidget {
  const ResponsiveAddUserScreen({super.key});

  @override
  State<ResponsiveAddUserScreen> createState() =>
      _ResponsiveAddUserScreenState();
}

class _ResponsiveAddUserScreenState extends State<ResponsiveAddUserScreen> {
  late UsersManagementCubit _usersManagementCubit;

  @override
  void initState() {
    super.initState();
    _usersManagementCubit = GetIt.instance<UsersManagementCubit>();
  }

  @override
  void dispose() {
    _usersManagementCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _usersManagementCubit,
      child: ResponsiveBuilder(
        builder: (context, isMobile) {
          if (isMobile) {
            return const MobileAddUserScreen();
          } else {
            return const TabletAddUserScreen();
          }
        },
      ),
    );
  }
}
