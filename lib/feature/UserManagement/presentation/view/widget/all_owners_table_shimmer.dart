import 'package:flutter/material.dart';
import '../../../../../core/const/widget/table/headercell.dart';
import '../../../../../core/utils/colors/colors.dart';
import '../../../../../core/widgets/shimmer_loading.dart';
import '../../../../../l10n/app_localizations.dart';

class AllOwnersTableShimmer extends StatelessWidget {
  final int itemCount;

  const AllOwnersTableShimmer({super.key, this.itemCount = 8});

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
              children: [
                HeaderCell(text: AppLocalizations.of(context)!.email, flex: 2),
                HeaderCell(text: AppLocalizations.of(context)!.name, flex: 2),
                HeaderCell(
                  text: AppLocalizations.of(context)!.villa_number,
                  flex: 2,
                ),
                HeaderCell(text: AppLocalizations.of(context)!.phone, flex: 2),
                HeaderCell(text: AppLocalizations.of(context)!.image, flex: 2),
                HeaderCell(text: AppLocalizations.of(context)!.action, flex: 2),
              ],
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
                    // Email
                    Expanded(
                      flex: 2,
                      child: Center(child: ShimmerBox(width: 140, height: 14)),
                    ),
                    // Name
                    Expanded(
                      flex: 2,
                      child: Center(child: ShimmerBox(width: 80, height: 14)),
                    ),
                    // Villa Number
                    Expanded(
                      flex: 2,
                      child: Center(child: ShimmerBox(width: 30, height: 14)),
                    ),
                    // Phone
                    Expanded(
                      flex: 2,
                      child: Center(child: ShimmerBox(width: 100, height: 14)),
                    ),
                    // Image - Circle like in real table
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ShimmerBox(width: 40, height: 40, borderRadius: 20),
                        ],
                      ),
                    ),
                    // Action Buttons - matching real buttons
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ShimmerBox(width: 70, height: 36, borderRadius: 8),
                          const SizedBox(width: 8),
                          ShimmerBox(width: 60, height: 36, borderRadius: 8),
                        ],
                      ),
                    ),
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
}
