import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UsersTableShimmer extends StatelessWidget {
  const UsersTableShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(
          const Color(0xFF9DC183).withOpacity(0.2),
        ),
        columns: const [
          DataColumn(label: Text('الاسم الكامل')),
          DataColumn(label: Text('البريد الإلكتروني')),
          DataColumn(label: Text('رقم الهاتف')),
          DataColumn(label: Text('الصلاحية')),
        ],
        rows: List.generate(
          5,
          (index) => DataRow(
            cells: [
              DataCell(_buildShimmerCell()),
              DataCell(_buildShimmerCell()),
              DataCell(_buildShimmerCell()),
              DataCell(_buildShimmerCell()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerCell() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 100,
        height: 20,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
