part of 'auth_cubit.dart';

@immutable

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserModel data;

  AuthSuccess({required this.data});
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}

class AuthForgetPasswordSuccess extends AuthState {
  final String data;

  AuthForgetPasswordSuccess({required this.data});
}

class AuthResetPasswordSuccess extends AuthState {
  final String data;

  AuthResetPasswordSuccess({required this.data});
}