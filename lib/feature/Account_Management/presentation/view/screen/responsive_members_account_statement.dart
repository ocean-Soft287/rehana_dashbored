import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rehana_dashboared/feature/Account_Management/presentation/manger/person_cubit.dart';
import '../widget/members_account_statement_mobile.dart';
import '../widget/members_account_statement_tablet.dart';

class ResponsiveMembersAccountStatement extends StatelessWidget {
  const ResponsiveMembersAccountStatement({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<PersonCubit>(),
      child: Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              return Builder(
                builder: (context) {
                  if (constraints.maxWidth < 600) {
                    return MembersAccountStatementMobile();
                  } else {

                    return MembersAccountStatementTablet();
                  }
                },
              );
            },
          )
      ),
    );
  }
}
