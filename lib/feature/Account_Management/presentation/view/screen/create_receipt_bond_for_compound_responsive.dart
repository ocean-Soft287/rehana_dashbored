import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../manger/person_cubit.dart';
import '../widget/create_receipt_bond_compound_mobile.dart';
import '../widget/create_receipt_bond_compound_tablet.dart';

class CreateReceiptBondForCompoundResponsive extends StatelessWidget {
  const CreateReceiptBondForCompoundResponsive({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController amount=TextEditingController();
    TextEditingController date=TextEditingController();

    return BlocProvider(
      create: (context) => GetIt.instance<PersonCubit>(),
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Builder(
              builder: (context) {
                if (constraints.maxWidth < 600) {
                  return CreateReceiptBondCompoundMobile(
                    dateController: date,
                    amountController: amount,);
                } else {
                  return CreateReceiptBondCompoundTablet(
                    dateController: date,
                    amountController: amount,);
                }
              },
            );
          },
        ),
      ),
    );
  }
}
