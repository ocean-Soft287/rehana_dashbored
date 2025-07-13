class VisitInvitation {
  final String id;
  final int memberId;
  final String memberUserName;
  final int memberVillaNumber;
  final String status;
  final DateTime dateFrom;
  final DateTime dateTo;
  final String reasonForVisit;
  final String invitationType;

  VisitInvitation({
    required this.id,
    required this.memberId,
    required this.memberUserName,
    required this.memberVillaNumber,
    required this.status,
    required this.dateFrom,
    required this.dateTo,
    required this.reasonForVisit,
    required this.invitationType,
  });

  factory VisitInvitation.fromJson(Map<String, dynamic> json) {
    return VisitInvitation(
      id: json['id'] as String,
      memberId: json['memberId'] as int,
      memberUserName: json['memberUserName'] as String,
      memberVillaNumber: json['memberVillaNumber'] as int,
      status: json['status'] as String,
      dateFrom: DateTime.parse(json['dateFrom'] as String),
      dateTo: DateTime.parse(json['dateTo'] as String),
      reasonForVisit: json['reasonForVisit'] as String,
      invitationType: json['invitationType'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'memberId': memberId,
      'memberUserName': memberUserName,
      'memberVillaNumber': memberVillaNumber,
      'status': status,
      'dateFrom': dateFrom.toIso8601String(),
      'dateTo': dateTo.toIso8601String(),
      'reasonForVisit': reasonForVisit,
      'invitationType': invitationType,
    };
  }
}
