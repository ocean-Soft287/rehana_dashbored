import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/const/widget/mobile_table/row_item.dart';
import 'package:rehana_dashboared/l10n/app_localizations.dart';
import '../../manger/person_cubit.dart';


class SummarybondbyyearStatementMobile extends StatefulWidget {
  const SummarybondbyyearStatementMobile({super.key, required this.villa_number});
  final int villa_number;

  @override
  State<SummarybondbyyearStatementMobile> createState() => _SummarybondbyyearStatementMobileState();
}

class _SummarybondbyyearStatementMobileState extends State<SummarybondbyyearStatementMobile> {
  @override
  void initState() {
    super.initState();
    context.read<PersonCubit>().getsummarybondbyvillanumber(widget.villa_number);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonCubit, PersonState>(
      builder: (context, state) {
        if (state is Summarybondbyvillanumbersuccful) {
          final data = state.data;

          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final row = data[index];
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues( alpha:0.07),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                            border: Border.all(color: const Color(0xFFE2E2E2)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                RowItem(label:AppLocalizations.of(context)!.year, value: row.year.toString()),
                                RowItem(label:AppLocalizations.of(context)!.paid, value: row.totalDisbursement.toString()),
                                RowItem(label:AppLocalizations.of(context)!.residual, value: row.totalReceipt.toString()),
                              ],
                            ),
                          ),
                        ),
                        if (index != data.length - 1) const SizedBox(height: 10),
                      ],
                    );
                  },
                  childCount: data.length,
                ),
              ),
            ],
          );
        } else {
          return const Center();
        }
      },
    );
  }
}
