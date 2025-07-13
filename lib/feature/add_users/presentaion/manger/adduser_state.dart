part of 'adduser_cubit.dart';


@immutable
abstract class AdduserState {}

class AdduserInitial extends AdduserState {}

class AdduserLoading extends AdduserState {}

class AdduserSuccess extends AdduserState {
  final OwnerModel owner;
  AdduserSuccess(this.owner);
}

class AdduserFailure extends AdduserState {
  final String message;
  AdduserFailure(this.message);
}
class EditImagePickerProfileViewSuccess extends AdduserState{}

class EditImagePickerProfileViewError extends AdduserState{}

class EditImagePickerProfileViewLoading extends AdduserState{}

class Addsecuritysucces extends AdduserState {
  final SecurityGuardModel securityGuardModel;

  Addsecuritysucces({required this.securityGuardModel});

}

class AddsecurityFailure extends AdduserState {
  final String message;
  AddsecurityFailure(this.message);
}

class AddpersonFailure extends AdduserState {
  final String message;
  AddpersonFailure(this.message);
}
class AdduserpersonSuccess extends AdduserState {
  final Person person;

  AdduserpersonSuccess({required this.person});


}