class BulkDisbursementModel {
  final List<String> villaNumbers;
  final double pricePerMeter;
  final String date;
  final String currency;
  final String bondDescription;

  BulkDisbursementModel({
    required this.villaNumbers,
    required this.pricePerMeter,
    required this.date,
    required this.currency,
    required this.bondDescription,
  });

  Map<String, dynamic> toJson() {
    return {
      'villaNumbers': villaNumbers,
      'pricePerMeter': pricePerMeter,
      'date': date,
      'currency': "EGP",
      'bondDescription': bondDescription,
    };
  }
}
