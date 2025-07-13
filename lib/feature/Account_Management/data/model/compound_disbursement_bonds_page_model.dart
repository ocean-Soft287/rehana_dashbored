import 'compound_disbursement_bond_model.dart';

class CompoundDisbursementBondsPageModel {
  final List<CompoundDisbursementBondModel> items;
  final int page;
  final int pageSize;
  final int totalItems;
  final int totalPages;

  CompoundDisbursementBondsPageModel({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
  });

  factory CompoundDisbursementBondsPageModel.fromJson(Map<String, dynamic> json) {
    return CompoundDisbursementBondsPageModel(
      items: (json['items'] as List)
          .map((item) => CompoundDisbursementBondModel.fromJson(item))
          .toList(),
      page: json['page'],
      pageSize: json['pageSize'],
      totalItems: json['totalItems'],
      totalPages: json['totalPages'],
    );
  }
}
