class CompoundDisbursementBondModel {
  final int id;
  final String date;
  final String currency;
  final String ownerEmail;
  final double amount;
  final String ownerId;

  CompoundDisbursementBondModel({
    required this.id,
    required this.date,
    required this.currency,
    required this.ownerEmail,
    required this.amount,
    required this.ownerId,
  });

  factory CompoundDisbursementBondModel.fromJson(Map<String, dynamic> json) {
    return CompoundDisbursementBondModel(
      id: json['id'],
      date: json['date'],
      currency: json['currency'],
      ownerEmail: json['ownerEmail'],
      amount: (json['amount'] as num).toDouble(),
      ownerId: json['ownerId'],
    );
  }
}
