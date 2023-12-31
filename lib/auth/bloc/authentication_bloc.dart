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
      print(
          'STARTING AUTH FIRED---------------------- -------------- --------------------------');
      await authStarted(event, emit);
    });
    on<AuthenticationStateChanged>((event, emit) async {
      await authStateChanged(event, emit);
    });
    on<AuthSetUser>(
      (event, emit) {
        print('------------------ ----------------> Upd L: ${event.username}');
        emit(
          state.copyWith(
            username: event.username,
          ),
        );
        print('Updated User : ${state.username}');
      },
    );
    on<AuthSetPass>(
      (event, emit) {
        print('Upd P: ${event.password}');
        emit(state.copyWith(password: event.password));
        print('New P: ${state.password}');
      },
    );
    on<AuthSetStat>(
      (event, emit) {
        print('Current State : ${state.authState}');
        print(
            'Emitting New State : ${event.authState}   user : ${state.username} ');
        emit(state.copyWith(authState: event.authState));
        print('New (Current) State Emitted : ${state.authState}');
      },
    );
    on<AuthPrintState>(
      (event, emit) =>
          print('Current Sta : ${state.authState} User : ${state.username}'),
    );
  }

  Future<void> authStarted(event, emit) async {
    print('46. Auth Started');
    try {
      String? login = state.username;
      String? password = state.password;
      Box<EmployeeHiveModel> emp = Hive.box(HiveTagNames.Employee_Hive_Tag);
      if (emp.length == 0) {
        print('emp Empty');
        emit(state.copyWith(authState: AuthState.dataEmpty));
      }
      print('52. Login : $login : ${password}');
      if (login == null || login.isEmpty) {
        print('Auth Failure No Login : 56');
        emit(state.copyWith(authState: AuthState.failure));
        return;
      }
      print('l');
      print('emp : ${emp.length}');
      emit(state.copyWith(authState: AuthState.loading));

      emp.values.forEach((element) {
        print('${element.UserName} : ${element.Password}');
      });
      EmployeeHiveModel empL = emp.values.firstWhere(
        (element) => element.UserName == login && element.Password == password,
        orElse: () => EmployeeHiveModel(),
      );

      print('Login : ${empL.UserName} : ${empL.Password}');
      if (empL.id != null) {
        Box sett = Hive.box(HiveTagNames.Settings_Hive_Tag);
        await sett.put('Salesman_ID', empL.id);
        emit(state.copyWith(authState: AuthState.success));
        return;
      } else {
        print('Auth Failure emitting : 63');
        emit(state.copyWith(authState: AuthState.failure));
        return;
      }

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
