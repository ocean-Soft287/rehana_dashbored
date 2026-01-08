class VillaListModel {
  final int villaNumber;
  final String memberName;

  VillaListModel({required this.villaNumber, required this.memberName});

  factory VillaListModel.fromJson(Map<String, dynamic> json) {
    return VillaListModel(
      villaNumber: json['villaNumber'] as int,
      memberName: json['memberName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'villaNumber': villaNumber, 'memberName': memberName};
  }
}
