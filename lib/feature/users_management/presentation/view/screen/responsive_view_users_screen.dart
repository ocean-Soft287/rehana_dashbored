import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../../core/utils/responsive/responsive_builder.dart';
import '../../manger/users_management_cubit.dart';
import '../widgets/mobile_view_users_screen.dart';
import '../widgets/tablet_view_users_screen.dart';

class ResponsiveViewUsersScreen extends StatefulWidget {
  const ResponsiveViewUsersScreen({super.key});

  @override
  State<ResponsiveViewUsersScreen> createState() =>
      _ResponsiveViewUsersScreenState();
}

class _ResponsiveViewUsersScreenState extends State<ResponsiveViewUsersScreen> {
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
            return const MobileViewUsersScreen();
          } else {
            return const TabletViewUsersScreen();
          }
        },
      ),
    );
  }
}
