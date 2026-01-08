import 'package:flutter/material.dart';
import '../../../../../core/widgets/shimmer_loading.dart';

class AllOwnersMobileShimmer extends StatelessWidget {
  final int itemCount;

  const AllOwnersMobileShimmer({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ShimmerBox(width: 120, height: 28),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList.separated(
              itemCount: itemCount,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with image and name
                      Row(
                        children: [
                          ShimmerBox(width: 60, height: 60, borderRadius: 30),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ShimmerBox(width: 120, height: 18),
                                const SizedBox(height: 8),
                                ShimmerBox(width: 80, height: 14),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Email
                      Row(
                        children: [
                          ShimmerBox(width: 60, height: 14),
                          const SizedBox(width: 8),
                          ShimmerBox(width: 140, height: 14),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Phone
                      Row(
                        children: [
                          ShimmerBox(width: 60, height: 14),
                          const SizedBox(width: 8),
                          ShimmerBox(width: 100, height: 14),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Villa Number
                      Row(
                        children: [
                          ShimmerBox(width: 60, height: 14),
                          const SizedBox(width: 8),
                          ShimmerBox(width: 40, height: 14),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ShimmerBox(height: 36, borderRadius: 8),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ShimmerBox(height: 36, borderRadius: 8),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
