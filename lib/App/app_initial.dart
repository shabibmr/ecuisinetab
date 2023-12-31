import 'package:ecuisinetab/Login/login_page.dart';
import 'package:ecuisinetab/Screens/POS/pos_screen.dart';
import 'package:ecuisinetab/Screens/POS/widgets/Configurations/configurations.dart';
import 'package:ecuisinetab/Utils/voucher_types.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Services/Sync/bloc/sync_ui_config_bloc.dart';
import '../Transactions/blocs/pos/pos_bloc.dart';
import '../Transactions/blocs/voucher_bloc/voucher_bloc.dart';
import '../auth/bloc/authentication_bloc.dart';

class Init_App extends StatefulWidget {
  const Init_App({Key? key}) : super(key: key);

  @override
  State<Init_App> createState() => _Init_AppState();
}

class _Init_AppState extends State<Init_App> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SyncServiceBloc, SyncServiceState>(
      listener: (context, state) {
        if (state.status == SyncUiConfigStatus.fetched) {
          print('fetch Completed');
          context.read<AuthenticationBloc>().add(AuthenticationStarted());
        }
      },
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listenWhen: (previous, current) =>
            previous.authState != current.authState,
        listener: (context, state) {
          print(
              'new state ${state.authState} ${context.read<AuthenticationBloc>().state.msg} ${context.read<AuthenticationBloc>().state.username}  ');
          if (state.authState == AuthState.failure) {
            openLoginWidget();
          } else if (state.authState == AuthState.success) {
            openPOSScreen(context);
          } else if (state.authState == AuthState.dataEmpty) {
            context.read<SyncServiceBloc>().add(FetchAllMastersEvent());
          } else if (state.authState == AuthState.configEmpty) {
            // show Config Page
          }
        },
        child: Builder(
          builder: (contextBuilder) {
            var stat = contextBuilder
                .select((AuthenticationBloc bloc) => bloc.state.authState);
            print('77. BUILDER STATE State : $stat ');
            if (stat == AuthState.loading || stat == AuthState.started) {
              return Scaffold(
                body: Center(
                  child: Text('Logging in  User : ${stat}'),
                ),
              );
            }
            return Scaffold(
              body: Center(
                child: Column(
                  children: [
                    Text('Hello!!! $stat'),
                    IconButton(
                      onPressed: () {
                        context
                            .read<AuthenticationBloc>()
                            .add(AuthenticationStarted());
                      },
                      icon: Icon(Icons.cleaning_services),
                    ),
                    IconButton(
                      onPressed: () {
                        print(
                            'pressed ${contextBuilder.read<AuthenticationBloc>().state.username}');
                        context
                            .read<AuthenticationBloc>()
                            .add(AuthPrintState());
                        context
                            .read<AuthenticationBloc>()
                            .add(AuthSetStat(authState: AuthState.failure));
                      },
                      icon: Icon(Icons.cleaning_services),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void openLoginWidget() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: context.read<AuthenticationBloc>(),
          ),
        ],
        child: LoginWidget(),
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
        ],
        child: ConfigurationPage(),
      ),
    ));
  }

  void openPOSScreen(BuildContext context) {
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
                ..add(SetPriceList(priceListID: 3)),
            )
          ],
          child: POSScreen(),
        ),
      ),
    );
  }
}
