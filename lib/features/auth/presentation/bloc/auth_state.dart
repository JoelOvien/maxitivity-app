part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  LoginSuccess({required this.data});
  final AbstractApiResponse data;
}

class LoginError extends AuthState {
  LoginError({required this.error});
  final String error;
}
