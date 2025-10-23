import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../../bar_navigation/manger/bar_cubit.dart';
import '../../manger/person_cubit.dart';
import '../widget/summarybondbyyear_statement_mobile.dart';
import '../widget/summarybondbyyear_statement_tablet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SummarybondbyyearStatementResponsive extends StatelessWidget {
  const SummarybondbyyearStatementResponsive({super.key});

  @override
  Widget build(BuildContext context) {
    final villaNumber = context
        .read<BottomCubit>()
        .villa_number;

    return BlocProvider(
      create: (context) => GetIt.instance<PersonCubit>(),
      child: Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              return constraints.maxWidth < 600
                  ? SummarybondbyyearStatementMobile(villa_number: villaNumber,)
                  : SummarybondbyyearStatementTablet(villa_number: villaNumber,);
            },
          )
      ),
    );
  }
}
