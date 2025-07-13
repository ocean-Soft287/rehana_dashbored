import 'package:rehana_dashboared/feature/Home/data/model/visitinvitation.dart';

class PaginatedVisitInvitations {
  final List<VisitInvitation> items;
  final int page;
  final int pageSize;
  final int totalItems;
  final int totalPages;

  PaginatedVisitInvitations({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
  });

  factory PaginatedVisitInvitations.fromJson(Map<String, dynamic> json) {
    return PaginatedVisitInvitations(
      items: (json['items'] as List)
          .map((item) => VisitInvitation.fromJson(item))
          .toList(),
      page: json['page'] as int,
      pageSize: json['pageSize'] as int,
      totalItems: json['totalItems'] as int,
      totalPages: json['totalPages'] as int,
    );
  }
}
