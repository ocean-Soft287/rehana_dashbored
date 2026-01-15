import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../manger/person_cubit.dart';
import '../widget/disbursement_vouchers_mobile.dart';
import '../widget/disbursement_vouchers_tablet.dart';

class DisbursementVouchersResponsive extends StatelessWidget {
  const DisbursementVouchersResponsive({super.key});

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
                  return DisbursementVouchersMobile();
                } else {
                  return DisbursementVouchersTablet();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
