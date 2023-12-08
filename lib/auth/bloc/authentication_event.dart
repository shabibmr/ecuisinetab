// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationStateChanged extends AuthenticationEvent {
  final AuthenticationDetail authenticationDetail;

  const AuthenticationStateChanged({required this.authenticationDetail});
  @override
  List<Object> get props => [authenticationDetail];
}

class AuthenticationExited extends AuthenticationEvent {}

class AuthSetUser extends AuthenticationEvent {
  final String username;

  AuthSetUser({required this.username});
}

class AuthSetPass extends AuthenticationEvent {
  final String password;

  AuthSetPass({required this.password});
}
