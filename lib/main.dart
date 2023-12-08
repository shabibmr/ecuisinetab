import 'package:ecuisinetab/Login/login_page.dart';
import 'package:ecuisinetab/Screens/POS/pos_screen.dart';
import 'package:ecuisinetab/auth/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'App/app_initial.dart';
import 'Services/Sync/bloc/sync_ui_config_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eCuisineTab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ecuisineTabApp(title: 'eCuisineTab'),
    );
  }
}

class ecuisineTabApp extends StatefulWidget {
  ecuisineTabApp({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ecuisineTabApp> createState() => _ecuisineTabAppState();
}

class _ecuisineTabAppState extends State<ecuisineTabApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (contextQ) => SyncServiceBloc(),
        ),
        BlocProvider(
          create: (context) =>
              AuthenticationBloc()..add(AuthenticationStarted()),
        ),
      ],
      child: Init_App(),
    );
  }
}
