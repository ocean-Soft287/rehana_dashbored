import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../Home/data/model/visitrow_model.dart';
import '../../manger/person_cubit.dart';
import '../widget/exchange_bond_tablet.dart';
import '../widget/exchange_bonds_mobile.dart';

class ExchangebondsResponsive extends StatefulWidget {
  const ExchangebondsResponsive({super.key});

  @override
  State<ExchangebondsResponsive> createState() =>
      _ExchangebondsResponsiveState();
}

class _ExchangebondsResponsiveState extends State<ExchangebondsResponsive> {
  @override
  Widget build(BuildContext context) {
    List<VisitRow> getRows() =>
        List.generate(
          10,
              (index) =>
              VisitRow(
                fileNumber: "11/2/2025",
                date: "جنيه مصري",
                name: "7584644356586",
                time: "محمد فتحي",
                reason: "43",
                status: "",
              ),
        );
    return BlocProvider(
      create: (context) => GetIt.instance<PersonCubit>(),
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Builder(
              builder: (context) {
                final rows = getRows();

                if (constraints.maxWidth < 600) {
                  return ExchangeBondsMobile(rows: rows,);
                } else {
                  return ExchangeBondTablet(rows: rows,);
                }
              },
            );
          },
        ),
      ),
    );
  }
}
