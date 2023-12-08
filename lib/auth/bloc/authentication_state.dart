// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_bloc.dart';

enum AuthState { intitial, started, loading, success, failure }

class AuthenticationState extends Equatable {
  const AuthenticationState({this.authState, this.authDetail, this.msg});
  final AuthState? authState;
  final AuthenticationDetail? authDetail;
  final String? msg;

  @override
  List<Object?> get props => [];

  AuthenticationState copyWith({
    AuthState? authState,
    AuthenticationDetail? authDetail,
    String? msg,
  }) {
    return AuthenticationState(
      authState: authState ?? this.authState,
      authDetail: authDetail ?? this.authDetail,
      msg: msg ?? this.msg,
    );
  }
}
