import 'dart:io';

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
  HttpOverrides.global = MyHttpOverrides();
  await initSettings();
  await initHiveBoxes();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> initSettings() async {
  // Map<String, dynamic> item = {};
  // item['dbName'] = 'cake_studio_mukkam';

  await Hive.initFlutter();
  Box sett = await Hive.openBox(HiveTagNames.Settings_Hive_Tag);
  String dbname = sett.get(Config_Tag_Names.DBName_Tag,
      defaultValue: HiveTagNames.Default_DB);
  sett.put(Config_Tag_Names.DBName_Tag, dbname);

  String serverIP = sett.get(Config_Tag_Names.Server_IP_Tag,
      defaultValue: HiveTagNames.Default_Server_IP);

  sett.put(Config_Tag_Names.Server_IP_Tag, serverIP);
  String url = sett.get(Config_Tag_Names.Base_URL_Tag,
      defaultValue:
          'http://${HiveTagNames.Default_Server_IP}/${HiveTagNames.Default_endpoint}');
  sett.put(Config_Tag_Names.Base_URL_Tag, url);

  String api = sett.get(Config_Tag_Names.App_Endpoint_Tag,
      defaultValue: HiveTagNames.Default_endpoint);
  sett.put(Config_Tag_Names.App_Endpoint_Tag, api);

  String billPrinter =
      sett.get(Config_Tag_Names.Bill_Printer_Tag, defaultValue: 'Counter');
  sett.put(Config_Tag_Names.Bill_Printer_Tag, billPrinter);
  // sett.put('CompanyName', item['CompanyName'] ?? '');
  // sett.put('branch', item['branch'] ?? '');
  // sett.put('addressLine', item['addressline'] ?? '');
  // sett.put('vPref', item['VoucherPrefix'] ?? 'A');
  // sett.put('Salesman_ID', item['Emp_ID']);
  // sett.put('Warehouse', item['Godown_ID'] ?? 'GODOWN');
  sett.put(Config_Tag_Names.Default_Godown_ID, 'GODOWN');
  // sett.put('defaultCash', item['defaultCash'] ?? '');
  sett.put(Config_Tag_Names.Default_Bank_Tag, '0x5x21x2');
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
  await Hive.openBox(HiveTagNames.Config_Hive_Tag);

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
        BlocProvider(lazy: false, create: (context) => SyncServiceBloc()
            // ..add(
            //   const FetchAllMastersEvent(),
            // ),
            ),
        BlocProvider(lazy: false, create: (context) => AuthenticationBloc()
            // ..add(AuthSetUser(username: 'user'))
            // ..add(AuthSetPass(password: '123456'))
            // ..add(AuthenticationStarted()),
            ),
      ],
      child: MaterialApp(
        title: 'eCuisineTab',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(
              255,
              137,
              233,
              200,
            ),
          ),
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
