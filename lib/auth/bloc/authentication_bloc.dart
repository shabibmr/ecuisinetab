import 'dart:async';

import 'package:ecuisinetab/Datamodels/HiveModels/Employee/EmployeeHiveModel.dart';
import 'package:ecuisinetab/Login/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/authentication_detail.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc()
      : super(const AuthenticationState(
          authState: AuthState.intitial,
          msg: "hi!",
        )) {
    on<AuthenticationStarted>((event, emit) async {
      await authStarted(event, emit);
    });
    on<AuthenticationStateChanged>((event, emit) async {
      await authStateChanged(event, emit);
    });
    on<AuthSetUser>(
      (event, emit) {
        emit(
          state.copyWith(
            username: event.username,
          ),
        );
      },
    );
    on<AuthSetPass>(
      (event, emit) {
        emit(state.copyWith(password: event.password));
      },
    );
    on<AuthSetStat>(
      (event, emit) {
        emit(state.copyWith(authState: event.authState));
      },
    );
    on<AuthPrintState>(
      (event, emit) =>
          print('Current Sta : ${state.authState} User : ${state.username}'),
    );
  }

  Future<void> authStarted(event, emit) async {
    try {
      String? login = state.username;
      String? password = state.password;
      Box<EmployeeHiveModel> emp = Hive.box(HiveTagNames.Employee_Hive_Tag);
      if (emp.length == 0) {
        emit(state.copyWith(authState: AuthState.dataEmpty));
      }
      if (login == null || login.isEmpty) {
        emit(
          state.copyWith(
            authState: AuthState.failure,
            msg: 'Please enter username',
          ),
        );
        return;
      }
      if (password == null || password.isEmpty) {
        emit(
          state.copyWith(
            authState: AuthState.failure,
            msg: 'Please enter password',
          ),
        );
        return;
      }
      emit(state.copyWith(authState: AuthState.loading));

      EmployeeHiveModel empL = emp.values.firstWhere(
        (element) => element.UserName == login && element.Password == password,
        orElse: () => EmployeeHiveModel(),
      );

      if (empL.id != null) {
        Box sett = Hive.box(HiveTagNames.Settings_Hive_Tag);
        await sett.put(Config_Tag_Names.Salesmain_ID_Tag, empL.id);
        emit(state.copyWith(authState: AuthState.success));
        return;
      } else {
        emit(
          state.copyWith(
            authState: AuthState.failure,
            msg: 'User not found',
          ),
        );
        return;
      }

      // check login info;
    } catch (e) {
      if (kDebugMode) {
        print(
            'Error occured while fetching authentication detail : ${e.toString()}');
      }
      emit(state.copyWith(msg: 'Login Error', authState: AuthState.failure));
    }
  }

  Future<void> authExited(event, emit) async {
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
