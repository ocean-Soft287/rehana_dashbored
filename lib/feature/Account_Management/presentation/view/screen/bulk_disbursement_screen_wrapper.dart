import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rehana_dashboared/core/utils/responsive/responsive_builder.dart';
import 'package:rehana_dashboared/feature/Account_Management/presentation/manger/bulk_disbursement_cubit.dart';
import 'package:rehana_dashboared/feature/Account_Management/presentation/view/widgets/mobile_bulk_disbursement_screen.dart';
import 'package:rehana_dashboared/feature/Account_Management/presentation/view/widgets/tablet_bulk_disbursement_screen.dart';

/// Wrapper for BulkDisbursementScreen with BlocProvider and Responsive Layout
/// Uses GetIt to get the cubit instance
class BulkDisbursementScreenWrapper extends StatelessWidget {
  const BulkDisbursementScreenWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<BulkDisbursementCubit>(),
      child: ResponsiveBuilder(
        builder: (context, isMobile) {
          if (isMobile) {
            return const MobileBulkDisbursementScreen();
          } else {
            return const TabletBulkDisbursementScreen();
          }
        },
      ),
    );
  }
}
