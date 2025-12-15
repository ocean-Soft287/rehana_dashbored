import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../../core/utils/responsive/responsive_builder.dart';
import '../../manger/user_cubit.dart';
import '../widget/all_owners_mobile.dart';
import '../widget/all_owners_tablet.dart';

class ResponsiveAllOwners extends StatefulWidget {
  const ResponsiveAllOwners({super.key});

  @override
  State<ResponsiveAllOwners> createState() => _ResponsiveAllOwnersState();
}

class _ResponsiveAllOwnersState extends State<ResponsiveAllOwners> {
  late UserCubit _userCubit;

  @override
  void initState() {
    super.initState();
    _userCubit = GetIt.instance<UserCubit>()..getallmemeber();
  }

  @override
  void dispose() {
    _userCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _userCubit,
      child: Scaffold(
        body: ResponsiveBuilder(
          builder: (context, isMobile) {
            if (isMobile) {
              return const AllOwnersMobile();
            } else {
              return const AllOwnersTablet();
            }
          },
        ),
      ),
    );
  }
}
