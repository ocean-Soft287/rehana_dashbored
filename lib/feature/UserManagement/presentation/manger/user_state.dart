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
  final List<UserModel> userModel;

  Getallmemebersuccful({required this.userModel});


}
class GetallmemeberLoading extends UserState {}
class Getallmemeberfailure extends UserState {
  final String message;

  Getallmemeberfailure({required this.message});

}