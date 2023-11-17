// ignore_for_file: must_be_immutable

part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginUserEvent extends AuthEvent {
  LoginUserEvent({required this.data});
  RequestParams<String> data;
}
