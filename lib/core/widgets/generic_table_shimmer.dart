import 'package:flutter/material.dart';
import '../const/widget/table/headercell.dart';
import '../utils/colors/colors.dart';
import 'shimmer_loading.dart';

/// Generic Table Shimmer that can be used for any table view
class GenericTableShimmer extends StatelessWidget {
  final List<TableColumn> columns;
  final int itemCount;
  final bool showActionButtons;

  const GenericTableShimmer({
    super.key,
    required this.columns,
    this.itemCount = 8,
    this.showActionButtons = true,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Header - WITHOUT Shimmer
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              color: Appcolors.kprimary,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              children:
                  columns.map((col) {
                    return HeaderCell(text: col.title, flex: col.flex);
                  }).toList(),
            ),
          ),
        ),
        // Shimmer Rows - WITH Shimmer effect
        SliverList.separated(
          itemCount: itemCount,
          itemBuilder: (_, index) {
            final bgColor =
                index.isOdd ? const Color(0xFFF6F9ED) : Colors.white;

            return Container(
              color: bgColor,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ShimmerLoading(
                child: Row(
                  children: [
                    // Create shimmer boxes based on column configuration
                    ...columns.map((col) {
                      return Expanded(
                        flex: col.flex,
                        child: _buildColumnShimmer(col),
                      );
                    }).toList(),
                  ],
                ),
              ),
            );
          },
          separatorBuilder:
              (_, __) => const Divider(height: 0, color: Color(0xFFE2E2E2)),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 50)),
      ],
    );
  }

  Widget _buildColumnShimmer(TableColumn column) {
    switch (column.type) {
      case ColumnType.text:
        return Center(
          child: ShimmerBox(width: column.shimmerWidth, height: 14),
        );
      case ColumnType.image:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ShimmerBox(width: 40, height: 40, borderRadius: 20)],
        );
      case ColumnType.buttons:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShimmerBox(width: 70, height: 36, borderRadius: 8),
            const SizedBox(width: 8),
            ShimmerBox(width: 60, height: 36, borderRadius: 8),
          ],
        );
    }
  }
}

/// Configuration for table columns
class TableColumn {
  final String title;
  final int flex;
  final ColumnType type;
  final double shimmerWidth;

  TableColumn({
    required this.title,
    this.flex = 1,
    this.type = ColumnType.text,
    this.shimmerWidth = 100,
  });
}

enum ColumnType { text, image, buttons }
