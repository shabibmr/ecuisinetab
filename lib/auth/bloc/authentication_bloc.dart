import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../models/authentication_detail.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc()
      : super(AuthenticationState(
            authDetail: AuthenticationDetail(),
            authState: AuthState.intitial)) {
    on<AuthenticationStarted>((event, emit) {
      authStarted(event, emit);
    });
    on<AuthenticationStateChanged>((event, emit) async {
      await authStateChanged(event, emit);
    });
    on<AuthSetUser>(
      (event, emit) {
        emit(state.copyWith(
            authDetail: state.authDetail?.copyWith(username: event.username)));
      },
    );
    on<AuthSetPass>(
      (event, emit) {
        emit(state.copyWith(
            authDetail: state.authDetail?.copyWith(password: event.password)));
      },
    );
  }

  @override
  Future<void> close() {
    return super.close();
  }

  void authStarted(event, emit) {
    print('Auth Started');
    emit(state.copyWith(authState: AuthState.success));
    try {
      String login = state.authDetail?.username ?? '';
      String password = state.authDetail?.password ?? '';
      print('Auth Success');
      emit(state.copyWith(authState: AuthState.success));
      // check login info;
    } catch (e) {
      if (kDebugMode) {
        print(
            'Error occured while fetching authentication detail : ${e.toString()}');
      }
      print('Emitting Failure!!!');
      emit(state.copyWith(authState: AuthState.failure));
    }
  }

  Future<void> authExited(event, emit) async {
    print('Loging user out');
    try {
      emit(state.copyWith(authState: AuthState.loading));
      // await _authenticationRepository.unAuthenticate();
    } catch (error) {
      if (kDebugMode) {
        print('Error occured while logging out. : ${error.toString()}');
      }
      emit(state.copyWith(authState: AuthState.loading));
    }
  }

  Future<void> authStateChanged(event, emit) async {
    if (event.authenticationDetail.isValid!) {
      emit(state.copyWith(authState: AuthState.success));
    } else {
      emit(state.copyWith(
          msg: 'User has logged out', authState: AuthState.failure));
    }
  }
}
