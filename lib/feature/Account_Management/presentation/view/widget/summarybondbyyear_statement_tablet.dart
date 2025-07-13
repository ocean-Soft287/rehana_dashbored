import 'package:flutter/cupertino.dart'
    show BuildContext, Color, Container, Padding, Widget;
import 'package:flutter/material.dart'
    show Colors, Divider, Material, TextDirection;
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart'
    show BorderRadius, CustomScrollView, Row, SizedBox, SliverList, SliverToBoxAdapter;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehana_dashboared/core/const/widget/table/headercell.dart'
    show HeaderCell;
import 'package:rehana_dashboared/core/const/widget/table/data_cell.dart'
    show DataCell;

import '../../../../../core/utils/colors/colors.dart';
import '../../../../../generated/l10n.dart';
import '../../manger/person_cubit.dart';



class SummarybondbyyearStatementTablet extends StatefulWidget {
  const SummarybondbyyearStatementTablet({super.key, required this.villanumber});

  final int villanumber;

  @override
  State<SummarybondbyyearStatementTablet> createState() => _SummarybondbyyearStatementTabletState();
}

class _SummarybondbyyearStatementTabletState extends State<SummarybondbyyearStatementTablet> {
  @override
  void initState() {
    super.initState();
    context.read<PersonCubit>().getsummarybondbyvillanumber(widget.villanumber);
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonCubit, PersonState>(
  builder: (context, state) {
      if (state is Summarybondbyvillanumbersuccful) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: CustomScrollView(
                slivers: [
                  // Header Row
                  SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Appcolors.kprimary,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      child: Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          HeaderCell(text: S
                              .of(context)
                              .year, flex: 2),
                          HeaderCell(text: S
                              .of(context)
                              .Paid,),
                          HeaderCell(text: S
                              .of(context)
                              .residual),
                        ],
                      ),
                    ),
                  ),
                  // Data Rows
                  SliverList.separated(
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      final row = state.data[index];
                      final bgColor =
                      index.isOdd ? const Color(0xFFF6F9ED) : Colors.white;
                      return Container(
                        color: bgColor,
                        child: Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            DataCell(text: row.year.toString(), flex: 2),
                            DataCell(text: row.totalDisbursement.toString()),
                            DataCell(text: row.totalReceipt.toString()),

                          ],
                        ),
                      );
                    },
                    separatorBuilder:
                        (context, index) =>
                    const Divider(height: 0, color: Color(0xFFE2E2E2)),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      else{
        return const SizedBox();

      }
  },
);
  }
}
