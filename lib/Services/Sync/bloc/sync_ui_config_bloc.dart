import 'package:ecuisinetab/Datamodels/HiveModels/PriceList/PriceListEntriesHive.dart';
import 'package:ecuisinetab/Datamodels/HiveModels/PriceList/PriceListMasterHive.dart';

import '../../../Datamodels/HiveModels/AccountGroups/AccountGroupHiveModel.dart';
import '../../../Datamodels/HiveModels/Employee/EmployeeHiveModel.dart';
import '../../../Datamodels/HiveModels/Godown/GodownHiveModel.dart';
import '../../../Datamodels/HiveModels/InventoryGroups/InventorygroupHiveModel.dart';
import '../../../Datamodels/HiveModels/InventoryItems/InvetoryItemDataModel.dart';
import '../../../Datamodels/HiveModels/Ledgers/LedMasterHiveModel.dart';
import '../../../Datamodels/HiveModels/UOM/UOMHiveModel.dart';
import '../../../Datamodels/HiveModels/UserGroup/user_group_datamodel.dart';

import '../../../Datamodels/HiveModels/address_book/contacts_data_model.dart';
import '../../../Login/constants.dart';
import '../../../Webservices/webservicePHP.dart';
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

import 'package:hive/hive.dart';

part 'sync_ui_config_event.dart';
part 'sync_ui_config_state.dart';

class SyncServiceBloc extends Bloc<SyncServiceEvent, SyncServiceState> {
  SyncServiceBloc()
      : super(const SyncServiceState(
          status: SyncUiConfigStatus.init,
        )) {
    on<CheckServer>((event, emit) async => await checkServer(event, emit));

    on<FetchItemsEvent>((event, emit) async {
      bool n = await syncItems();
      print('Items Fetched');
    });

    on<FetchItemGroupsEvent>((event, emit) async {
      bool n = await syncItemGroups();
      print('Groups Fetched');
    });
    on<FetchLedgersEvent>((event, emit) async {
      await syncLedgers();
    });
    on<FetchAccGroupsEvent>((event, emit) async {
      await syncAccGroups();
    });
    on<FetchUOMEvent>((event, emit) async {
      await syncUOMs();
    });
    on<FetchEmployeesEvent>((event, emit) async {
      await syncEmployees();
      // await syncUserGroups();
    });
    on<FetchGodownsEvent>((event, emit) async {
      await syncGodowns();
    });
    on<FetchPricesEvent>((event, emit) async {
      await syncPrices();
    });
    on<FetchAllMastersEvent>((event, emit) async {
      emit(state.copyWith(status: SyncUiConfigStatus.fetching));
      try {
        bool itemsSync = await syncItems();
        if (itemsSync) {
          emit(state.copyWith(itemsSynced: true));
        }
        await syncItemGroups();
        // await syncGodowns();
        await syncLedgers();
        // await syncAccGroups();
        await syncUOMs();
        await syncEmployees();
        await syncPrices();
        await readConfigs();
        await syncContacts();
      } catch (e) {
        emit(state.copyWith(status: SyncUiConfigStatus.error));
        print('Error : $e');
      }
      // await syncUserGroups();
      emit(state.copyWith(status: SyncUiConfigStatus.fetched));
    });

    on<FetchUIConfigEvent>((event, emit) async {
      return;
      print('Sync Event');
      Box box = Hive.box(HiveTagNames.UI_Config_Hive_Tag);
      emit(state.copyWith(status: SyncUiConfigStatus.fetching));
      final data = await WebservicePHPHelper.getUIConfig();
      // final String response = await rootBundle.loadString('assets/ui.json');
      // List data = await json.decode(d);
      // print('UI Config : ${data.runtimeType} - ${data.length}');
      if (data == false) {
        print('UI Config Fetch : Error');
      } else {
        emit(state.copyWith(status: SyncUiConfigStatus.fetched));
        int k = 0;
        try {
          k = await insertElems(data, box);
          print(' k is $k');

          print('k count :  box :${box.length}');
        } catch (e) {
          print('Error : $e');
        }

        emit(state.copyWith(
            status: SyncUiConfigStatus.updated, msg: 'Updated $k '));

        print('UI CON Len : ${box.length}');
      }
    });
  }

  Future<int> insertElems(List data, Box<dynamic> box) async {
    int k = 0;

    List fs = [];

    data.forEach((element) {
      // print('$k : ${element['id']}');
      box.put(element['id'], element);

      k++;
      // if (element['filters'] != null) {
      //   Map f = jsonDecode(element['filters']);
      //   fs.addAll(jsonDecode(f['dateTime']));
      // }
    });
    // print('Loop done');
    // fs = fs.toSet().toList();

    // print('returning >>> $fs');
    return k;
  }

  Future<bool> syncItems() async {
    print('Fetching Inventory items ${DateTime.now()}');
    bool flag = true;
    String qry = "";
    DateTime last = DateTime(2021);

    try {
      final dataResponse = await WebservicePHPHelper.getAllInventoryItems(
        lastUpdatedTimestamp: last,
      );
      if (dataResponse == false) {
        throw Exception('Fetch Error');
      }

      Box<InventoryItemHive> box = Hive.box(HiveTagNames.Items_Hive_Tag);
      await box.clear();
      Box<PriceListEntriesHive> pbox =
          Hive.box(HiveTagNames.PriceListsEntries_Hive_Tag);
      await pbox.clear();

      dataResponse.forEach((element) async {
        // print('${element}');
        try {
          // print('Type ele : ${element.runtimeType}');
          InventoryItemHive item = InventoryItemHive.fromMap(element);
          await box.put(item.Item_ID, item);
          final pMap = element['PriceLists'];
          print('Price Map : $pMap');
          pMap.forEach((element2) async {
            print('Price List : $element2');
            PriceListEntriesHive price = PriceListEntriesHive.fromMap(element2);
            await pbox.put(item.Item_ID, price);
          });
        } catch (e) {
          print('Conv error : ${e.toString()}');
          return false;
        }
      });
      print('Inventory Items FETCHED : ${box.length}');
    } catch (e) {
      print('Erro : ${e.toString()} ');
      return false;
    }
    return flag;
  }

  Future<bool> syncItemGroups() async {
    print('Fetching item Groups ${DateTime.now()}');
    bool flag = false;
    String qry = "";
    DateTime last = DateTime(2021);
    final dataResponse = await WebservicePHPHelper.getAllInventoryGroups(
      lastUpdated: last,
    );
    if (dataResponse == false) {
      print('Fetch Eroor');
    }
    Box<InventorygroupHiveModel> box =
        Hive.box(HiveTagNames.ItemGroups_Hive_Tag);
    await box.clear();
    // print('Box cleared');
    try {
      dataResponse.forEach((element) async {
        // print('${element}');
        InventorygroupHiveModel group =
            InventorygroupHiveModel.fromMap(element);
        await box.put(element['Group_Id'], group);
      });
    } catch (e) {
      print('Error Adding to Hive : ${e.toString()}');
    }

    print('Groups : ${box.length} at ${DateTime.now()}');
    return flag;
  }

  Future<bool> syncLedgers() async {
    print('Fetching Leds ${DateTime.now()}');
    bool flag = false;
    DateTime last = DateTime(2021);
    final dataResponse = await WebservicePHPHelper.getAllLedgers(
      lastUpdated: last,
    );
    if (dataResponse == false) {
      print('Fetch Error');
    }
    Box<LedgerMasterHiveModel> box = Hive.box(HiveTagNames.Ledgers_Hive_Tag);
    try {
      await box.clear();

      dataResponse.forEach((element) async {
        LedgerMasterHiveModel ledger = LedgerMasterHiveModel.fromMap(element);
        await box.put(element['Ledger_Id'], ledger);
      });
    } catch (e) {
      print('Error Adding to Hive : ${e.toString()}');
    } finally {
      print('Ledgers : ${box.length} ${DateTime.now()}');
    }

    return flag;
  }

  Future<bool> syncEmployees() async {
    print('Fetching Emps');
    bool flag = false;

    DateTime last = DateTime(2021);
    final dataResponse = await WebservicePHPHelper.getAllEmployees(
      lastUpdated: last,
    );
    if (dataResponse == false) {
      print('Fetch Eroor');
    }
    Box<EmployeeHiveModel> box = Hive.box(HiveTagNames.Employee_Hive_Tag);
    await box.clear();
    // print('Box cleared');
    try {
      dataResponse.forEach((element) async {
        // print('${element}');
        EmployeeHiveModel emp = EmployeeHiveModel.fromMap(element);
        await box.put(int.parse(element['_id'] ?? "0"), emp);
      });
    } catch (e) {
      print('Error Adding to Hive : ${e.toString()}');
    }

    print('Emps : ${box.length}');

    return flag;
  }

  Future<bool> syncUserGroups() async {
    print('Fetching Emps');
    bool flag = false;

    DateTime last = DateTime(2021);
    final dataResponse = await WebservicePHPHelper.getAllUserGroups(
      lastUpdated: last,
    );
    if (dataResponse == false) {
      print('Fetch Eroor');
    }
    Box<UserGroupDataModel> box = Hive.box(HiveTagNames.UserGroups_Hive_Tag);
    await box.clear();
    // print('Box cleared');
    try {
      dataResponse.forEach((element) async {
        // print('${element}');
        UserGroupDataModel emp = UserGroupDataModel.fromMap(element);
        await box.put(int.parse(element['_id'] ?? "0"), emp);
      });
    } catch (e) {
      print('Error Adding to Hive : ${e.toString()}');
    }

    print('UserGroups : ${box.length}');

    return flag;
  }

  Future<bool> syncGodowns() async {
    print('Fetching Godowns');
    bool flag = false;
    String qry = "";
    DateTime last = DateTime(2021);
    final dataResponse = await WebservicePHPHelper.getAllGodowns(
      lastUpdated: last,
    );
    if (dataResponse == false) {
      print('Fetch Eroor - GODOWNS');
      return false;
    }
    Box<GodownHiveModel> box = Hive.box(HiveTagNames.Godowns_Hive_Tag);
    await box.clear();
    // print('Box cleared');
    try {
      dataResponse.forEach((element) async {
        // print('${element}');
        GodownHiveModel godownObj = GodownHiveModel.fromMap(element);
        await box.put(element['Godown_ID'], godownObj);
      });
    } catch (e) {
      print('Error Adding to Hive : ${e.toString()}');
    }

    print('Godowns  : ${box.length}');
    return flag;
  }

  Future<bool> syncUOMs() async {
    print('Fetching uom ${DateTime.now()}');
    bool flag = false;
    String qry = "";
    DateTime last = DateTime(2021);
    final dataResponse = await WebservicePHPHelper.getAllUOM(
      lastUpdated: last,
    );
    if (dataResponse == false) {
      print('Fetch Eroor');
    } else {
      // print('uom');
      // print(dataResponse.runtimeType);
    }
    Box<UOMHiveMOdel> box = Hive.box(HiveTagNames.Uom_Hive_Tag);
    await box.clear();
    // print('UOM Box cleared');
    try {
      dataResponse.forEach((element) async {
        // print('${element}');
        UOMHiveMOdel uom = UOMHiveMOdel.fromMap(element);
        // print('Uom $uom');
        await box.put(int.parse(element['Uom_id']), uom);
      });
    } catch (e) {
      print('Error Adding to Hive : ${e.toString()}');
    }
    print('Uoms : ${box.length}');
    return flag;
  }

  Future<bool> readConfigs() async {
    print('Fetching uom ${DateTime.now()}');
    bool flag = false;
    final dataResponse = await WebservicePHPHelper.getConfigSettings(
      keysList: [
        Config_Tag_Names.Allow_Discount_Tag,
        Config_Tag_Names.Rate_Editable_Tag,
      ],
    );

    if (dataResponse == false) {
      print('Fetch Eroor');
    } else {
      // print('uom');
      print(dataResponse);
    }
    Box sett = Hive.box(HiveTagNames.Config_Hive_Tag);
    // sett.put(Config_Tag_Names.Server_IP_Tag, state.serverIP);

    // await box.clear();
    // print('UOM Box cleared');
    try {
      dataResponse.forEach((element) async {
        var val = element['GMValue'] == "1";
        print('${element['GMKey']}: ${val.runtimeType}');

        sett.put(element['GMKey'], val);
      });
    } catch (e) {
      print('Error Adding to Hive : ${e.toString()}');
    }
    print('Config : ${sett.length}');
    return flag;
  }

  Future<bool> syncAccGroups() async {
    print('Fetching accGrps');
    bool flag = false;
    String qry = "";
    DateTime last = DateTime(2021);
    final dataResponse = await WebservicePHPHelper.getAccountgroups(
      lastUpdated: last,
    );
    if (dataResponse == false) {
      print('Fetch Eroor');
    } else {
      // print("acc Grps : $dataResponse");
    }
    Box<AccountGroupHiveModel> box =
        Hive.box(HiveTagNames.AccountGroups_Hive_Tag);
    await box.clear();
    print('Box cleared');
    try {
      dataResponse.forEach((element) async {
        // print('${element}');
        AccountGroupHiveModel acc = AccountGroupHiveModel.fromMap(element);
        await box.put(element['Group_Id'], acc);
      });
    } catch (e) {
      print('Error Adding to Hive : ${e.toString()}');
    }

    print('Acc Grps : ${box.length}');
    return flag;
  }

  Future<bool> syncPrices() async {
    bool flag = false;
    String qry = "";
    DateTime last = DateTime(2021);
    Box<PriceListMasterHive> box = Hive.box(HiveTagNames.PriceLists_Hive_Tag);
    // Box<PriceListMasterHive> pricelistBox =
    //     Hive.box(HiveTagNames.PriceListsEntries_Hive_Tag);

    try {
      final List dataResponse =
          await WebservicePHPHelper.getAllPriceList(lastUpdated: last);

      await box.clear();
      // await pricelistBox.clear();

      dataResponse.forEach((element) async {
        // print('>> ${element}');
        final PriceListMasterHive p = PriceListMasterHive.fromMap(element);
        // print('Name : ${p.priceListName}');

        print(element['Price_List_ID'].runtimeType);
        await box.put(element['Price_List_ID'], p);
      });
    } catch (e) {
      print('Error : $e');
    } finally {
      print('PRICES : ${box.length}');
    }
    return flag;
  }

  Future<bool> checkServer(event, emit) async {
    return true;
  }

  Future<bool> syncContacts() async {
    print('Fetching Contacts');
    bool flag = false;
    DateTime last = DateTime(2021);
    Box<ContactsDataModel> box = Hive.box(HiveTagNames.Contacts_Hive_Tag);
    await box.clear();

    try {
      final dataResponse =
          await WebservicePHPHelper.getAllContacts(lastUpdated: last);
      if (dataResponse == false) {
        print('Fetch Eroor');
      } else {
        print('Contacts Fetched');
        dataResponse.forEach((element) async {
          ContactsDataModel contact = ContactsDataModel.fromMap(element);
          await box.put(element['Contact_ID'], contact);
        });
        flag = true;
      }
    } catch (e) {
      print('Error : $e');
    }
    print('Contacts : ${box.length}');
    return flag;
  }
}
