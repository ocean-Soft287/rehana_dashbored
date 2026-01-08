part of 'security_cubit.dart';


@immutable

abstract class SecurityState {}

class SecurityInitial extends SecurityState {}

class SecuritySuccful extends SecurityState {
  final List<SecurityGuardModel> securityguard;

  SecuritySuccful({required this.securityguard});
}

class SecurityFailure extends SecurityState {
  final String error;

  SecurityFailure({required this.error});
}

class Securitydelete extends SecurityState {
  final String message;

  Securitydelete(this.message);
}

class SecurityLoading extends SecurityState {}

class SecurityUpdate extends SecurityState {
  final SecurityGuardModel securityGuardModel;

  SecurityUpdate({required this.securityGuardModel});
}

class EditImagePickerProfileViewSuccess extends SecurityState {}

class EditImagePickerProfileViewError extends SecurityState {}
