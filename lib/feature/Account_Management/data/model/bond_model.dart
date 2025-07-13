class BondModel {
  final String date;
  final String currency;
  final String bondDescription;
  final String type;
  final double amount;
  final int villaNumber;
  final String memberName;

  BondModel({
    required this.date,
    required this.currency,
    required this.bondDescription,
    required this.type,
    required this.amount,
    required this.villaNumber,
    required this.memberName,
  });

  factory BondModel.fromJson(Map<String, dynamic> json) {
    return BondModel(
      date: json['date'] as String,
      currency: json['currency'] as String,
      bondDescription: json['bondDescription'] as String,
      type: json['type'] as String,
      amount: (json['amount'] as num).toDouble(),
      villaNumber: json['villaNumber'] as int,
      memberName: json['memberName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'currency': currency,
      'bondDescription': bondDescription,
      'type': type,
      'amount': amount,
      'villaNumber': villaNumber,
      'memberName': memberName,
    };
  }
}
