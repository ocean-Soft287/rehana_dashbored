import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../manger/person_cubit.dart';
import '../widget/create_abond_mobile.dart';
import '../widget/create_bond_ablet.dart';

class ResponsiveCreateAbond extends StatefulWidget {
  const ResponsiveCreateAbond({super.key});

  @override
  State<ResponsiveCreateAbond> createState() => _ResponsiveCreateAbondState();
}

class _ResponsiveCreateAbondState extends State<ResponsiveCreateAbond> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController currencyController = TextEditingController();
  final TextEditingController creditorController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController villaNumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

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
                    return CreateBondMobile(
                      dateController: dateController,
                      currencyController: currencyController,
                      accountNumberController: accountNumberController,
                      descriptionController: descriptionController,
                      villaNumberController: villaNumberController,
                      amountController: amountController,
                    );
                  } else {
                    return CreateBondTablet(
                      dateController: dateController,
                      currencyController: currencyController,
                      accountNumberController: accountNumberController,
                      descriptionController: descriptionController,
                      villaNumberController: villaNumberController,
                      amountController: amountController,
                    );
                  }
                },
              );
            },
          )
      ),
    );
  }
}
//////