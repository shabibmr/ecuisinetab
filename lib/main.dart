import 'package:ecuisinetab/auth/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import 'App/app_initial.dart';
import 'Datamodels/HiveModels/Employee/EmployeeHiveModel.dart';
import 'Datamodels/HiveModels/InventoryGroups/InventorygroupHiveModel.dart';
import 'Datamodels/HiveModels/InventoryItems/InvetoryItemDataModel.dart';
import 'Datamodels/HiveModels/Ledgers/LedMasterHiveModel.dart';
import 'Datamodels/HiveModels/PriceList/PriceListEntriesHive.dart';
import 'Datamodels/HiveModels/PriceList/PriceListMasterHive.dart';
import 'Datamodels/HiveModels/UOM/UOMHiveModel.dart';
import 'Login/constants.dart';
import 'Services/Sync/bloc/sync_ui_config_bloc.dart';

Future<void> main() async {
  // HiveTagNames.setDB('cake_studio_mukkam');

  await initSettings();
  await initHiveBoxes();
  runApp(const MyApp());
}

Future<void> initSettings() async {
  // Map<String, dynamic> item = {};
  // item['dbName'] = 'cake_studio_mukkam';

  await Hive.initFlutter();
  Box sett = await Hive.openBox(HiveTagNames.Settings_Hive_Tag);
  String dbname = sett.get('DBName', defaultValue: 'cake_studio_mukkam');

  String url =
      sett.get('url', defaultValue: 'http://192.168.0.106/test_app_water');

  sett.put('url', url);
  String billPrinter = sett.get('BillPrinter', defaultValue: 'Counter');
  sett.put('BillPrinter', billPrinter);
  // sett.put('CompanyName', item['CompanyName'] ?? '');
  // sett.put('branch', item['branch'] ?? '');
  // sett.put('addressLine', item['addressline'] ?? '');
  // sett.put('vPref', item['VoucherPrefix'] ?? 'A');
  // sett.put('Salesman_ID', item['Emp_ID']);
  // sett.put('Warehouse', item['Godown_ID'] ?? 'GODOWN');
  // sett.put('defaultGodown', item['defaultGodown'] ?? 'GODOWN');
  // sett.put('defaultCash', item['defaultCash'] ?? '');
  // sett.put('defaultbank', item['defaultBank'] ?? '');
  // sett.put('defaultPO', item['defaultPO'] ?? '');
  // sett.put('strictCreditLimit', item['strictCreditLimit'] ?? false);
  // sett.put('TRN', item['GSTRN'] ?? '');
  // sett.put('FSSAI', item['FSSAI'] ?? '');
  // sett.put('DBName', item['dbName'] ?? '');
  // sett.put('admin', item['admin'] ?? false);

  HiveTagNames.setDB(dbname);

  print('Tag : ${HiveTagNames.ItemGroups_Hive_Tag}');
}

Future<void> initHiveBoxes() async {
  Hive.registerAdapter<InventoryItemHive>(InventoryItemHiveAdapter());
  Hive.registerAdapter<InventorygroupHiveModel>(
      InventorygroupHiveModelAdapter());
  Hive.registerAdapter<UOMHiveMOdel>(UOMHiveMOdelAdapter());
  Hive.registerAdapter<EmployeeHiveModel>(EmployeeHiveModelAdapter());
  Hive.registerAdapter<PriceListEntriesHive>(PriceListEntriesHiveAdapter());
  Hive.registerAdapter<PriceListMasterHive>(PriceListMasterHiveAdapter());
  Hive.registerAdapter<LedgerMasterHiveModel>(LedgerMasterHiveModelAdapter());

  // Hive.registerAdapter<UserGroupDataModel>(UserGroupDataModelAdapter());
  // Hive.registerAdapter<ContactsDataModel>(ContactsDataModelAdapter());

  await Hive.openBox(HiveTagNames.UI_Config_Hive_Tag);

  Box box = await Hive.openBox(HiveTagNames.Values_Hive_Tag);

  String valKey = box.get(
    'UserKey',
    defaultValue: '',
  );

  if (valKey.isEmpty) {
    valKey = const Uuid().v1();
    box.put('UserKey', valKey);
  }

  Box<InventoryItemHive> itemsbox =
      await Hive.openBox(HiveTagNames.Items_Hive_Tag);
  Box<InventorygroupHiveModel> itemsGbox =
      await Hive.openBox(HiveTagNames.ItemGroups_Hive_Tag);
  Box<PriceListMasterHive> prices =
      await Hive.openBox(HiveTagNames.PriceLists_Hive_Tag);
  Box<PriceListEntriesHive> priceEntries =
      await Hive.openBox(HiveTagNames.PriceListsEntries_Hive_Tag);
  Box<LedgerMasterHiveModel> ledgers =
      await Hive.openBox(HiveTagNames.Ledgers_Hive_Tag);
  // Box<AccountGroupHiveModel> groups =
  //     await Hive.openBox(HiveTagNames.AccountGroups_Hive_Tag);
  // Box<GodownHiveModel> godowns =
  //     await Hive.openBox(HiveTagNames.Godowns_Hive_Tag);
  Box<UOMHiveMOdel> uoms = await Hive.openBox(HiveTagNames.Uom_Hive_Tag);
  Box<EmployeeHiveModel> emps =
      await Hive.openBox(HiveTagNames.Employee_Hive_Tag);
  // Box<UserGroupDataModel> userGrps =
  //     await Hive.openBox(HiveTagNames.UserGroups_Hive_Tag);
  // Box<ContactsDataModel> contactBox =
  //     await Hive.openBox(HiveTagNames.Contacts_Hive_Tag);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) =>
              SyncServiceBloc()..add(const FetchAllMastersEvent()),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => AuthenticationBloc()
            ..add(AuthenticationStarted())
            ..add(AuthSetUser(username: 'user'))
            ..add(AuthSetPass(password: '123456')),
        ),
      ],
      child: MaterialApp(
        title: 'eCuisineTab',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 137, 233, 130)),
          useMaterial3: true,
        ),
        home: const EcuisineTabApp(title: 'eCuisineTab'),
      ),
    );
  }
}

class EcuisineTabApp extends StatelessWidget {
  const EcuisineTabApp({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return const Init_App();
  }
}
/*
// class Just extends StatelessWidget {
//   const Just({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AuthenticationBloc, AuthenticationState>(
//       builder: (context, state) {
//         print(
//             '.................................................. .  JUST BUILDING   .................................................. .  ');
//         return Init_App();
//       },
//     );
//   }
// }

// class TestScreen extends StatelessWidget {
//   const TestScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AuthenticationBloc, AuthenticationState>(
//       listener: (context, state) {
//         print('Listening to New State : $state : ${state.authState}');
//       },
//       listenWhen: (previous, current) {
//         print('prev : ${previous.authState}');

//         print('Curr : ${current.authState}');
//         return true;
//       },
//       child: Scaffold(
//         body: Builder(
//           builder: (context) {
//             var status = context
//                 .select((AuthenticationBloc bloc) => bloc.state.authState);
//             print('New Status Changed at Scaffold Body  Build: $status');
//             return Center(
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Text('State is : $status'),
//                       IconButton(
//                         onPressed: () {
//                           print(
//                               '........................................................................................');
//                           print(
//                               'pressed ${context.read<AuthenticationBloc>().state.authState}');
//                           context
//                               .read<AuthenticationBloc>()
//                               .add(AuthPrintState());
//                           print(
//                               '........................................................................................');
//                         },
//                         icon: Icon(Icons.print),
//                       ),
//                     ],
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       context
//                           .read<AuthenticationBloc>()
//                           .add(AuthenticationStarted());
//                     },
//                     icon: Icon(Icons.cleaning_services),
//                   ),
//                   Text('to Failure '),
//                   IconButton(
//                     onPressed: () {
//                       print(
//                           'pressed ${context.read<AuthenticationBloc>().state.username}');
//                       context.read<AuthenticationBloc>().add(AuthPrintState());
//                       context
//                           .read<AuthenticationBloc>()
//                           .add(AuthSetStat(authState: AuthState.failure));
//                     },
//                     icon: Icon(Icons.family_restroom),
//                   ),
//                   Text('to Loading '),
//                   IconButton(
//                     onPressed: () {
//                       print(
//                           'pressed ${context.read<AuthenticationBloc>().state.username}');
//                       context.read<AuthenticationBloc>().add(AuthPrintState());
//                       context
//                           .read<AuthenticationBloc>()
//                           .add(AuthSetStat(authState: AuthState.loading));
//                     },
//                     icon: Icon(Icons.cleaning_services),
//                   ),
//                   Text('to Auth Started'),
//                   IconButton(
//                     onPressed: () {
//                       print(
//                           'pressed ${context.read<AuthenticationBloc>().state.username}');
//                       context.read<AuthenticationBloc>().add(AuthPrintState());
//                       context
//                           .read<AuthenticationBloc>()
//                           .add(AuthSetStat(authState: AuthState.started));
//                     },
//                     icon: Icon(Icons.cleaning_services),
//                   ),
//                   Text('To Initial'),
//                   IconButton(
//                     onPressed: () {
//                       print('pressed to intitial');
//                       context
//                           .read<AuthenticationBloc>()
//                           .add(AuthSetStat(authState: AuthState.intitial));
//                       context.read<AuthenticationBloc>().add(AuthPrintState());
//                     },
//                     icon: Icon(Icons.cleaning_services),
//                   ),
//                   Row(
//                     children: [
//                       Text('To New USer'),
//                       IconButton(
//                         onPressed: () {
//                           print('pressed to intitial');
//                           context
//                               .read<AuthenticationBloc>()
//                               .add(AuthSetUser(username: 'New User'));
//                           context
//                               .read<AuthenticationBloc>()
//                               .add(AuthPrintState());
//                         },
//                         icon: Icon(Icons.verified_user),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Text('To X USer'),
//                       IconButton(
//                         onPressed: () {
//                           print('pressed to intitial');
//                           context
//                               .read<AuthenticationBloc>()
//                               .add(AuthSetUser(username: 'XXX User'));
//                           context
//                               .read<AuthenticationBloc>()
//                               .add(AuthPrintState());
//                         },
//                         icon: Icon(Icons.verified_user),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
*/