import 'package:rehana_dashboared/feature/add_users/data/model/person_model.dart';

class PersonPageSize {
  final List<Person> items;
  final int page;
  final int pageSize;
  final int totalItems;
  final int totalPages;

  PersonPageSize({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
  });

  factory PersonPageSize.fromJson(Map<String, dynamic> json) {
    return PersonPageSize(
      items: (json['items'] as List<dynamic>)
          .map((item) => Person.fromJson(item))
          .toList(),
      page: json['page'],
      pageSize: json['pageSize'],
      totalItems: json['totalItems'],
      totalPages: json['totalPages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'page': page,
      'pageSize': pageSize,
      'totalItems': totalItems,
      'totalPages': totalPages,
    };
  }
}
