class Person {
  final int id;
  final String fullName;
  final String phoneNumber;
  final bool isMarried;
  final String address;
  final DateTime date;
  final int villaNumber;

  Person({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.isMarried,
    required this.address,
    required this.date,
    required this.villaNumber,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'] ?? 0,
      fullName: json['fullName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      isMarried: json['isMarried'] ?? false,
      address: json['address'] ?? '',
      date: json['date'] != null
          ? DateTime.tryParse(json['date']) ?? DateTime.now()
          : DateTime.now(),
      villaNumber: json['villaNumber'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'isMarried': isMarried,
      'address': address,
      'date': date.toIso8601String(),
      'villaNumber': villaNumber,
    };
  }
}
