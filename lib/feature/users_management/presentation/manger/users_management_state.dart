part of 'users_management_cubit.dart';

@immutable
abstract class UsersManagementState {}

class UsersManagementInitial extends UsersManagementState {}

class UsersManagementAddingUser extends UsersManagementState {}

class UsersManagementUserAdded extends UsersManagementState {
  final String message;

  UsersManagementUserAdded(this.message);
}

class UsersManagementLoadingUsers extends UsersManagementState {}

class UsersManagementUsersLoaded extends UsersManagementState {
  final List<UserModel> users;

  UsersManagementUsersLoaded(this.users);
}

class UsersManagementError extends UsersManagementState {
  final String message;

  UsersManagementError(this.message);
}
