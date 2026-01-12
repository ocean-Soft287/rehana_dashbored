class CollectionRequestModel {
  final String villaNumber;
  final double amount;
  final String date;
  final String currency;
  final String bondDescription;

  CollectionRequestModel({
    required this.villaNumber,
    required this.amount,
    required this.date,
    required this.currency,
    required this.bondDescription,
  });

  Map<String, dynamic> toJson() {
    return {
      'villaNumber': villaNumber,
      'amount': amount,
      'date': date,
      'currency': currency,
      'bondDescription': bondDescription,
    };
  }
}
