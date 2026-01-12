class VillaModel {
  final String villaNumber;
  final String ownerName;

  VillaModel({required this.villaNumber, required this.ownerName});

  factory VillaModel.fromJson(Map<String, dynamic> json) {
    return VillaModel(
      villaNumber: json['villaNumber']?.toString() ?? '',
      ownerName: json['ownerName']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'villaNumber': villaNumber, 'ownerName': ownerName};
  }

  @override
  String toString() => '$ownerName - فيلا $villaNumber';
}
