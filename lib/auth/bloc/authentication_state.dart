// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'authentication_bloc.dart';

enum AuthState {
  intitial,
  started,
  loading,
  success,
  failure,
  dataEmpty,
  configEmpty,
}

class AuthenticationState extends Equatable {
  const AuthenticationState({
    this.username,
    this.password,
    required this.authState,
    // required this.authDetail,
    this.msg,
  });
  final AuthState authState;
  // final AuthenticationDetail authDetail;
  final String? msg;

  final String? username;
  final String? password;

  @override
  List<Object?> get props => [authState, msg, username, password];

  AuthenticationState copyWith({
    AuthState? authState,
    // AuthenticationDetail? authDetail,
    String? msg,
    String? username,
    String? password,
  }) {
    return AuthenticationState(
      authState: authState ?? this.authState,
      // authDetail: authDetail ?? this.authDetail,
      msg: msg ?? this.msg,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}
