import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/login_model.dart';
import '../../data/repo/auth_repo.dart';

part 'auth_state.dart';


class AuthCubit extends Cubit<AuthState> {
  final LoginRepo loginRepo;

  AuthCubit(this.loginRepo) : super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());

    final response = await loginRepo.login(email: email, password: password);

    response.fold(
          (failure) => emit(AuthFailure(failure.message)),
          (data) => emit(AuthSuccess(data: data)),
    );
  }

  void forgetPassword({required String email}) async {
    emit(AuthLoading());

    final response = await loginRepo.forgetpassword(email: email);

    response.fold(
          (failure) => emit(AuthFailure(failure.message)),
          (data) => emit(AuthForgetPasswordSuccess(data: data)),
    );
  }

  void resetPassword({
    required String email,
    required String token,
    required String newPassword,
  }) async {
    emit(AuthLoading());

    final response = await loginRepo.resetpassword(
      email: email,
      token: token,
      newpassword: newPassword,
    );

    response.fold(
          (failure) {
        emit(AuthFailure(failure.message));
      }
      ,
          (data) => emit(AuthResetPasswordSuccess(data: data)),
    );
  }
}