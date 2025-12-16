part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}
final class AdduserLoading extends UserState {}
class Adduserfailure extends UserState {
  final String message;

  Adduserfailure({required this.message});
}

class Addusersuccful extends UserState{
  final UserModel userModel;

  Addusersuccful({required this.userModel});
}
class Getallmemebersuccful extends UserState{
  final List<OwnerModel> userModel;

  Getallmemebersuccful({required this.userModel});


}
class GetallmemeberLoading extends UserState {}
class Getallmemeberfailure extends UserState {
  final String message;

  Getallmemeberfailure({required this.message});


}

class GetAllUsersSuccessState extends UserState{
  final List<UserModel> userModel;

  GetAllUsersSuccessState({required this.userModel});


}
class GetAllUsersLoadingState extends UserState {}
class GetAllUsersFailureState extends UserState {
  final String message;

  GetAllUsersFailureState({required this.message});


}




class GetAllOwnersLoading extends UserState {}
class GetAllOwnersSuccess extends UserState {
  final List<OwnerModel> owners;
  GetAllOwnersSuccess(this.owners);
}
class GetAllOwnersFailure extends UserState {
  final String message;
  GetAllOwnersFailure(this.message);
}