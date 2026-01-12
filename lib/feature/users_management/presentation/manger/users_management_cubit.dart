import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/models/add_user_request_model.dart';
import '../../data/models/user_model.dart';
import '../../data/repo/users_management_repo.dart';

part 'users_management_state.dart';

class UsersManagementCubit extends Cubit<UsersManagementState> {
  final UsersManagementRepo usersManagementRepo;

  UsersManagementCubit(this.usersManagementRepo)
    : super(UsersManagementInitial());

  Future<void> addUser({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    required List<String> roles,
  }) async {
    emit(UsersManagementAddingUser());

    final request = AddUserRequestModel(
      email: email,
      password: password,
      fullName: fullName,
      phoneNumber: phoneNumber,
      roles: roles,
    );

    final result = await usersManagementRepo.addUser(request);

    result.fold(
      (failure) => emit(UsersManagementError(failure.message)),
      (message) => emit(UsersManagementUserAdded(message)),
    );
  }

  Future<void> loadAllUsers() async {
    emit(UsersManagementLoadingUsers());

    final result = await usersManagementRepo.getAllUsers();

    result.fold(
      (failure) => emit(UsersManagementError(failure.message)),
      (users) => emit(UsersManagementUsersLoaded(users)),
    );
  }
}
