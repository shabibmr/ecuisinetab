// ignore_for_file: camel_case_types

import 'package:ecuisinetab/Login/login_page.dart';
import 'package:ecuisinetab/Screens/POS/pos_screen.dart';
import 'package:ecuisinetab/Screens/POS/widgets/Configurations/configurations.dart';
import 'package:ecuisinetab/Screens/POS/widgets/common/gm_progress_indicator.dart';
import 'package:ecuisinetab/Utils/voucher_types.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Login/constants.dart';
import '../Services/Sync/bloc/sync_ui_config_bloc.dart';
import '../Transactions/blocs/pos/pos_bloc.dart';
import '../Transactions/blocs/voucher_bloc/voucher_bloc.dart';
import '../auth/bloc/authentication_bloc.dart';

class Init_App extends StatefulWidget {
  const Init_App({super.key});

  @override
  State<Init_App> createState() => _Init_AppState();
}

class _Init_AppState extends State<Init_App> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SyncServiceBloc, SyncServiceState>(
      listener: (context, state) async {
        if (state.status == SyncUiConfigStatus.fetching) {
          print("... fetching ...");
          await showDialog(
            context: context,
            builder: (contextB) {
              return BlocListener<SyncServiceBloc, SyncServiceState>(
                listener: (context2, state) {
                  print('state :$state');
                },
                child: const Dialog(
                  backgroundColor: Colors.transparent,
                  child: GMProgress(msg: "Fetching. masters.."),
                ),
              );
            },
          );
        } else if (state.status == SyncUiConfigStatus.fetched) {
          // context.read<AuthenticationBloc>().add(AuthenticationStarted());
          Navigator.pop(context);
          await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: const Text(
                    'Sync Completed',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Continue...'),
                    )
                  ],
                );
              });
        } else if (state.status == SyncUiConfigStatus.error) {
          Navigator.pop(context);
          await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: const Text(
                    'Sync Error!!',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        openConfigPage();
                      },
                      child: const Text('Retry'),
                    )
                  ],
                );
              });
        }
      },
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listenWhen: (previous, current) =>
            previous.authState != current.authState,
        listener: (context, state) {
          if (state.authState == AuthState.success) {
            openPOSScreen();
          } else if (state.authState == AuthState.dataEmpty) {
            // context.read<SyncServiceBloc>().add(const FetchAllMastersEvent());
          } else if (state.authState == AuthState.configEmpty) {
            openConfigPage();
          } else if (state.authState == AuthState.failure) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Login Failed'),
                  content: Text('Invalid Username or Password ${state.msg}'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          }
        },
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          buildWhen: (previous, current) {
            // print('cur : $current prev = $previous');
            if (current.authState == AuthState.success) {
              return false;
            }
            return true;
          },
          builder: (context, state) {
            final stat = state.authState;

            if (stat == AuthState.loading || stat == AuthState.started) {
              print('Stat : $stat');
              return const Scaffold(
                body: GMProgress(
                  msg: "Xoxo",
                ),
              );
            }
            if (stat == AuthState.failure ||
                stat == AuthState.intitial ||
                stat == AuthState.configEmpty ||
                stat == AuthState.dataEmpty) {
              return const LoginWidget();
            } else if (stat == AuthState.success) {
              return Center(
                child: TextButton(
                  onPressed: () {
                    openPOSScreen();
                  },
                  child: const Text('Open POS'),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  void openConfigPage({String? msg}) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: context.read<AuthenticationBloc>(),
          ),
        ],
        child: const ConfigurationPage(),
      ),
    ));
  }

  void openConfigWidget() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: context.read<AuthenticationBloc>(),
          ),
          BlocProvider.value(
            value: context.read<SyncServiceBloc>(),
          ),
        ],
        child: const ConfigurationPage(),
      ),
    ));
  }

  void openPOSScreen() {
    final int? defaultPrice =
        Hive.box(HiveTagNames.Settings_Hive_Tag).get("Default_Pricelist_Id");
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: context.read<SyncServiceBloc>()),
            BlocProvider.value(value: context.read<AuthenticationBloc>()),
            BlocProvider(
              create: (context) => PosBloc()..add(FetchCurrentOrders()),
            ),
            BlocProvider(
              create: (context) => VoucherBloc()
                ..add(SetEmptyVoucher(
                  voucherType: GMVoucherTypes.SalesOrder,
                ))
                ..add(SetPriceList(priceListID: defaultPrice ?? 1)),
            )
          ],
          child: POSScreen(),
        ),
      ),
    );
  }
}
