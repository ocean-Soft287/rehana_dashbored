class EndPoint {
  static String baseUrl = "http://78.89.159.126:9393/TheOneAPIRehana/api";
  // finsih
  static String login = "$baseUrl/Dashboard/loginOwner";
  static String forgetpassw = "$baseUrl/Dashboard/forgotpasswordOwner";
  static String changePassconfirm = "$baseUrl/Dashboard/resetpasswordOwner";

  ///ivitation finish

  static String allInvitations = "$baseUrl/Dashboard/allInvitations?page=";
  static String ownerOneTimeInvitation =
      "$baseUrl/Invitation/ownerOneTimeInvitation";

  ///member
  static String addmember = "$baseUrl/Dashboard/addMember";
  //addsecurity finish
  static String addsecuritygard = "$baseUrl/Dashboard/addSecurityGuard";
  static String allsecrity = "$baseUrl/Dashboard/getAllSecurityGuards";
  static String updatesecrity = "$baseUrl/Dashboard/updateSecurityGuard";
  static String deleteSecurityGuard =
      "$baseUrl/Dashboard/deleteSecurityGuard?id=";

  ///start
  static String createMemberAccount = "$baseUrl/Dashboard/createMemberAccount";
  static String updateMemberAccount = "$baseUrl/Dashboard/UpdateMemberAccount";
  static String deleteMemberAccount =
      "$baseUrl/Dashboard/deleteMemberAccount?id=";
  static String getAllMemberAccounts =
      "$baseUrl/Dashboard/GetAllMemberAccounts?page=";

  ///bond

  static String createBondForMember = "$baseUrl/Dashboard/memberReceipt";
  static String addCompoundDisbursementBond =
      "$baseUrl/Dashboard/addCompoundDisbursementBond";
  static String compounddisbursementbonds =
      "$baseUrl/Dashboard/CompoundDisbursementBonds?page=";
  static String getallmemberreceiptbonds =
      "$baseUrl/Dashboard/bonds?type=Receipt&page=";
  static String getallMemberdisbursementBonds =
      "$baseUrl/Dashboard/bonds?type=Disbursement&page=";
  static String getMemberAccountByVillaNumber =
      "$baseUrl/Dashboard/getMemberAccountByVillaNumber/";
  static String getbondssummarybyyearbyvillanumber =
      "$baseUrl/Dashboard/GetBondsSummaryByYearByVillaNumber?villaNumber=";
  static String addOwner = "$baseUrl/Dashboard/addOwner";
  static String getowner = "$baseUrl/Dashboard/getAllOwners";
  static String getAllMembers = "$baseUrl/Dashboard/getAllMembers";

  ///Dashboard
  static String villasList = "$baseUrl/Dashboard/list";
  static String bulkDisbursement = "$baseUrl/Dashboard/bulkDisbursement";

  ///Collections (مقبوضات)
  static String createCollection = "$baseUrl/Dashboard/memberReceipt";

  //chat

  static String updateMember = "$baseUrl/Dashboard/updateMember";
  static String deleteMember = "$baseUrl/Dashboard/deleteMember?id=";
}
