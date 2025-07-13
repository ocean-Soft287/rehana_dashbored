import 'bond_model.dart';

class BondPageModel {
  final List<BondModel> items;
  final int page;
  final int pageSize;
  final int totalItems;
  final int totalPages;

  BondPageModel({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
  });

  factory BondPageModel.fromJson(Map<String, dynamic> json) {
    return BondPageModel(
      items: (json['items'] as List)
          .map((e) => BondModel.fromJson(e))
          .toList(),
      page: json['page'],
      pageSize: json['pageSize'],
      totalItems: json['totalItems'],
      totalPages: json['totalPages'],
    );
  }
}