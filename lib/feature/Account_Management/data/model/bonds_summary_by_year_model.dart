class BondsSummaryByYearModel {
  final int year;
  final double totalReceipt;
  final double totalDisbursement;
  final double difference;

  BondsSummaryByYearModel({
    required this.year,
    required this.totalReceipt,
    required this.totalDisbursement,
    required this.difference,
  });

  factory BondsSummaryByYearModel.fromJson(Map<String, dynamic> json) {
    return BondsSummaryByYearModel(
      year: json['year'] as int,
      totalReceipt: (json['totalReceipt'] as num).toDouble(),
      totalDisbursement: (json['totalDisbursement'] as num).toDouble(),
      difference: (json['difference'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'totalReceipt': totalReceipt,
      'totalDisbursement': totalDisbursement,
      'difference': difference,
    };
  }
}
