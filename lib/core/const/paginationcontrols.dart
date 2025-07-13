import 'package:flutter/material.dart';

class PaginationControls extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const PaginationControls({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: currentPage > 1 ? onPrevious : null,
              child: const Text('السابق'),
            ),
            const SizedBox(width: 16),
            Text(
              "صفحة $currentPage من $totalPages",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: currentPage < totalPages ? onNext : null,
              child: const Text('التالي'),
            ),
          ],
        ),
      ),
    );
  }
}
