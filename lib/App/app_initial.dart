import 'package:ecuisinetab/Login/login_page.dart';
import 'package:ecuisinetab/Screens/POS/pos_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Services/Sync/bloc/sync_ui_config_bloc.dart';
import '../auth/bloc/authentication_bloc.dart';

class Init_App extends StatefulWidget {
  const Init_App({Key? key}) : super(key: key);

  @override
  State<Init_App> createState() => _Init_AppState();
}

class _Init_AppState extends State<Init_App> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state.authState == AuthState.failure) {
        return LoginWidget();
      }
      if (state.authState == AuthState.loading ||
          state.authState == AuthState.started) {
        return const Center(
          child: Text('Loging in  User'),
        );
      }
      return Center(
        child: Text('Hello!!! $state'),
      );
    }, listener: (context, state) {
      print('new state $state');
      // if (state is AuthenticationFailiure) {
      //   print('Pop Navigation from init page');
      //   Navigator.pop(context);
      // }
      if (state.authState == AuthState.success) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (contextRoute) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: context.read<SyncServiceBloc>()
                    // ..add(FetchUIConfigEvent())
                    ..add(FetchItemsEvent())
                    ..add(FetchItemGroupsEvent())
                    ..add(FetchLedgersEvent())
                    ..add(FetchUOMEvent())
                    ..add(FetchAccGroupsEvent())
                    ..add(FetchGodownsEvent())
                    ..add(FetchEmployeesEvent()),
                ),
                BlocProvider.value(value: context.read<AuthenticationBloc>()),
              ],
              child: POSScreen(),
            ),
          ),
        );
      }
    });
  }
}

class MastersSync extends StatelessWidget {
  const MastersSync({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (contextQ) => SyncServiceBloc()
        ..add(FetchUIConfigEvent())
        ..add(FetchItemsEvent())
        ..add(FetchItemGroupsEvent())
        ..add(FetchLedgersEvent())
        ..add(FetchUOMEvent())
        ..add(FetchAccGroupsEvent())
        ..add(FetchGodownsEvent())
        ..add(FetchEmployeesEvent()),
    );
  }
}
