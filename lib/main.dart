import 'package:ecuisinetab/Login/login_page.dart';
import 'package:ecuisinetab/Screens/POS/pos_screen.dart';
import 'package:ecuisinetab/auth/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import 'App/app_initial.dart';
import 'Datamodels/HiveModels/InventoryGroups/InventorygroupHiveModel.dart';
import 'Datamodels/HiveModels/InventoryItems/InvetoryItemDataModel.dart';
import 'Datamodels/HiveModels/PriceList/PriceListEntriesHive.dart';
import 'Datamodels/HiveModels/PriceList/PriceListMasterHive.dart';
import 'Datamodels/HiveModels/UOM/UOMHiveModel.dart';
import 'Login/constants.dart';
import 'Services/Sync/bloc/sync_ui_config_bloc.dart';

Future<void> main() async {
  HiveTagNames.setDB('cake_studio_mukkam');
  await initHiveBoxes();
  initSettings();

  runApp(const MyApp());
}

void initSettings() {
  Map<String, dynamic> item = {};
  item['dbName'] = 'cake_studio_mukkam';
  Box sett = Hive.box(HiveTagNames.Settings_Hive_Tag);
  sett.put('url', item['baseURL'] ?? 'http://192.168.0.107/test_app_water');
  sett.put('CompanyName', item['CompanyName'] ?? '');
  sett.put('branch', item['branch'] ?? '');
  sett.put('addressLine', item['addressline'] ?? '');
  sett.put('vPref', item['VoucherPrefix']);
  sett.put('Salesman_ID', item['Emp_ID']);
  sett.put('Warehouse', item['Godown_ID'] ?? 'GODOWN');
  sett.put('defaultGodown', item['defaultGodown'] ?? 'GODOWN');
  sett.put('defaultCash', item['defaultCash'] ?? '');
  sett.put('defaultbank', item['defaultBank'] ?? '');
  sett.put('defaultPO', item['defaultPO'] ?? '');
  sett.put('strictCreditLimit', item['strictCreditLimit'] ?? false);
  sett.put('TRN', item['GSTRN'] ?? '');
  sett.put('FSSAI', item['FSSAI'] ?? '');
  sett.put('DBName', item['dbName'] ?? '');
  sett.put('admin', item['admin'] ?? false);

  sett.put('type', item['type'] ?? 'App');
  sett.put('allowSave', item['allowSave'] ?? false);
  sett.put('showVoucherSplit', item['showVoucherSplit'] ?? false);
  sett.put('printOnSave', item['printOnSave'] ?? false);
  sett.put('showRates', item['showRates'] ?? true);
  sett.put('allowPrint', item['allowPrint'] ?? false);
  sett.put('showReceiptWithSales', item['showReceiptWithSales'] ?? false);
  sett.put('showAllVoucherPrefix', item['showAllVoucherPrefix'] ?? false);

  HiveTagNames.setDB(item['dbName'].toString());

  print('Tag : ${HiveTagNames.ItemGroups_Hive_Tag}');
}

Future<void> initHiveBoxes() async {
  await Hive.initFlutter();

  Hive.registerAdapter<InventoryItemHive>(InventoryItemHiveAdapter());
  Hive.registerAdapter<InventorygroupHiveModel>(
      InventorygroupHiveModelAdapter());
  Hive.registerAdapter<UOMHiveMOdel>(UOMHiveMOdelAdapter());
  // Hive.registerAdapter<EmployeeHiveModel>(EmployeeHiveModelAdapter());
  Hive.registerAdapter<PriceListEntriesHive>(PriceListEntriesHiveAdapter());
  // Hive.registerAdapter<UserGroupDataModel>(UserGroupDataModelAdapter());
  // Hive.registerAdapter<ContactsDataModel>(ContactsDataModelAdapter());

  await Hive.openBox(HiveTagNames.UI_Config_Hive_Tag);

  Box box = await Hive.openBox(HiveTagNames.Values_Hive_Tag);
  await Hive.openBox(HiveTagNames.Settings_Hive_Tag);

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
  // Box<LedgerMasterHiveModel> ledgers =
  //     await Hive.openBox(HiveTagNames.Ledgers_Hive_Tag);
  // Box<AccountGroupHiveModel> groups =
  //     await Hive.openBox(HiveTagNames.AccountGroups_Hive_Tag);
  // Box<GodownHiveModel> godowns =
  //     await Hive.openBox(HiveTagNames.Godowns_Hive_Tag);
  Box<UOMHiveMOdel> uoms = await Hive.openBox(HiveTagNames.Uom_Hive_Tag);
  // Box<EmployeeHiveModel> emps =
  //     await Hive.openBox(HiveTagNames.Employee_Hive_Tag);
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
