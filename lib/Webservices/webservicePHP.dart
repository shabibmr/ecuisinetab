import 'dart:convert';

import 'package:ecuisinetab/Login/constants.dart';
import 'package:ecuisinetab/Utils/voucher_types.dart';

import '/Datamodels/HiveModels/Employee/EmployeeHiveModel.dart';
import '/Datamodels/HiveModels/InventoryGroups/InventorygroupHiveModel.dart';
import '/Datamodels/HiveModels/InventoryItems/InvetoryItemDataModel.dart';

import '../Datamodels/HiveModels/address_book/contacts_data_model.dart';
import '../Datamodels/Masters/Accounts/LedgerMasterDataModel.dart';
import '../Datamodels/Transactions/general_voucher_datamodel.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class WebservicePHPHelper {
  static String getBaseURL() {
    Box sett = Hive.box('settings');
    String url = sett.get('url');
    // String url = 'https://192.168.0.104/test_app_water';

    // String url = 'https://www.algoray.in/test_app_water';

    // url = 'http://192.168.0.105/test_app_water';
    // print('Url : $url/');
    return '$url/';
  }

  static String getDBName() {
    Box settings = Hive.box('settings');

    // return 'aawater';

    return settings.get('DBName', defaultValue: 'gmdb');
  }

  static Future<GeneralVoucherDataModel> getVoucherByVoucherNo({
    required String voucherID,
    required String voucherPrefix,
    required String link,
    required String voucherTpe,
  }) async {
    String dBName = getDBName();
    Dio dio = Dio(); //BaseOptions(headers: {'dbname': dBName}));
    dio.options.headers['dbname'] = dBName;
    String url = "${getBaseURL()}$link";
    url = '$url&voucher_no=$voucherID&voucher_prefix=$voucherPrefix';

    url =
        '${getBaseURL()}transactions_webservice.php?action=getvoucherbyvoucherno&Voucher_No=$voucherID&Voucher_Prefix=$voucherPrefix&Voucher_Type=$voucherTpe';

    print("hellourl : $url");

    GeneralVoucherDataModel voucher;
    try {
      Response? response = await dio.get(url);

      Map<String, dynamic> data = response.data['data'];
      print(data);
      voucher = GeneralVoucherDataModel.fromMapForTransTest(data);
      print('V : ${voucher.voucherNumber}');
    } catch (e) {
      print(e.toString());
      return GeneralVoucherDataModel(
        ledgersList: const [],
      );
    }
    print('V no : ${voucher.voucherNumber}');
    // print('itemCount = ${voucher.InventoryItems.length}');
    // print('First item : ${voucher.InventoryItems[0].BaseItem.itemID}');
    return voucher;
  }

  static Future getVouchersByReqNo({
    required String reqId,
  }) async {
    String dBName = getDBName();
    Dio dio = Dio(BaseOptions(headers: {'dbname': dBName}));

    String url =
        '${getBaseURL()}reports_webservice.php?action=getVoucherList_ByReqNo&reqID=$reqId';

    print("hellourl : $url");

    final data;
    try {
      Response? response = await dio.get(url);
      data = response.data['data'];
      print(data);
    } catch (e) {
      print(e.toString());
      return null;
    }

    // print('itemCount = ${voucher.InventoryItems.length}');
    // print('First item : ${voucher.InventoryItems[0].BaseItem.itemID}');
    return data;
  }

  Future<GeneralVoucherDataModel> getVoucherByTransactionID({
    required String transID,
    required String link,
    required String voucherTpe,
  }) async {
    String dBName = getDBName();
    Dio dio = Dio(BaseOptions(headers: {'dbname': dBName}));
    String url = "${getBaseURL()}$link";

    url =
        '${getBaseURL()}transactions_webservice.php?action=getvoucher&trans_Id=$transID';

    print("hellourl : $url");

    GeneralVoucherDataModel voucher;
    try {
      Response? response = await dio.get(url);

      Map<String, dynamic> data = response.data['data'];
      print(data);
      voucher = GeneralVoucherDataModel.fromMapForTransTest(data);
    } catch (e) {
      print(e.toString());
      return GeneralVoucherDataModel(ledgersList: const []);
    }
    print('V no : ${voucher.voucherNumber}');
    // print('itemCount = ${voucher.InventoryItems.length}');
    // print('First item : ${voucher.InventoryItems[0].BaseItem.itemID}');
    return voucher;
  }

  static Future<dynamic> sendVoucher(
      {required final GeneralVoucherDataModel voucher,
      String? link,
      required String vType,
      bool? requestBillCopy}) async {
    // String url = '${baseURL}sales_order_webservice.php?action=upsertSalesOrder';

    Box sett = Hive.box(HiveTagNames.Settings_Hive_Tag);

    String printer = sett.get('BillPrinter', defaultValue: 'Counter');

    String fullURl =
        '${getBaseURL()}transactions_webservice.php?action=upsertTransaction&Voucher_Type=$vType';

    // print("url : $fullURl");
    print('BODY : ${voucher.toMapForTransTest()}');
    Response? response;

    // print(voucher.toMapForTransTest()['ledgersList']);
    try {
      String dBName = getDBName();
      // Hive.box('settings').get('DBName');
      Dio dio = Dio(); //BaseOptions(headers: {'dbname': dBName}));
      dio.options.headers['dbname'] = dBName;
      dio.options.headers['request_copy'] = requestBillCopy ?? false;
      dio.options.headers['printername'] = printer;

      print('dbName : $dBName');
      response = await dio.post(fullURl, data: voucher.toMapForTransTest());
    } catch (e) {
      print("url : $fullURl");

      print('From Web Service : ${e.toString()}');
      return {'Status': 'Failed'};
    }
    print('response ${response.data}');
    return response.data;
  }

  static Future<dynamic> saveItem({
    required final InventoryItemHive item,
  }) async {
    // String url = '${baseURL}sales_order_webservice.php?action=upsertSalesOrder';

    String fullURl =
        '${getBaseURL()}inventory_webservice.php?action=upsertItem&sendToOtherDBs=0';

    print("url : $fullURl");
    // print('BODY : ${voucher.toJsonTrans()}');
    Response? response;
    // print('Item : ${item.toJson()}');

    Map m = item.toMap();
    m["dbNames"] = ["aawater_test", "adukkala"];
    print(' Item : ${jsonEncode(m)}');
    // print(voucher.toMapForTransTest()['ledgersList']);
    try {
      String dBName = getDBName();
      // Hive.box('settings').get('DBName');
      Dio dio = Dio(); //BaseOptions(headers: {'dbname': dBName}));
      dio.options.headers['dbname'] = dBName;

      response = await dio.post(fullURl, data: m);
    } catch (e) {
      print('From Web Service : ${e.toString()}');
      return {
        "result": {'Status': 'Failed'}
      };
    }
    return response.data;
  }

  static Future<dynamic> saveGroup({
    required final InventorygroupHiveModel group,
  }) async {
    // String url = '${baseURL}sales_order_webservice.php?action=upsertSalesOrder';

    String fullURl =
        '${getBaseURL()}inventory_webservice.php?action=upsertItemGroup&sendToOtherDBs=1';

    print("url : $fullURl");
    // print('BODY : ${voucher.toJsonTrans()}');
    Response? response;
    // print('Item : ${item.toJson()}');

    Map m = group.toMap();
    m["dbNames"] = ["aawater_test", "adukkala"];
    print(' Item : ${jsonEncode(m)}');
    // print(voucher.toMapForTransTest()['ledgersList']);
    try {
      String dBName = getDBName();
      // Hive.box('settings').get('DBName');
      Dio dio = Dio(); //BaseOptions(headers: {'dbname': dBName}));
      dio.options.headers['dbname'] = dBName;

      response = await dio.post(fullURl, data: m);
    } catch (e) {
      print('From Web Service : ${e.toString()}');
      return {
        "result": {'Status': 'Failed'}
      };
    }
    return response.data;
  }

  static Future<dynamic> saveLedger({
    required final LedgerMasterDataModel ledger,
  }) async {
    // String url = '${baseURL}sales_order_webservice.php?action=upsertSalesOrder';

    String fullURl =
        '${getBaseURL()}masters_webservice.php?action=upsertLedger';

    print("url : $fullURl");
    // print('BODY : ${voucher.toJsonTrans()}');
    Response? response;
    print('Led : ${ledger.toMapforMasters()}');

    // print(voucher.toMapForTransTest()['ledgersList']);
    try {
      String dBName = getDBName();
      // Hive.box('settings').get('DBName');
      Dio dio = Dio(); //BaseOptions(headers: {'dbname': dBName}));
      dio.options.headers['dbname'] = dBName;

      response = await dio.post(fullURl, data: ledger.toMapforMasters());
    } catch (e) {
      print('From Web Service : ${e.toString()}');
      return {'Status': 'Failed'};
    }
    print('response ${response.data}');
    return response.data;
  }

  Future<List> getVoucherList({
    required DateTime dateFrom,
    required DateTime dateTo,
    required int offset,
    required int limit,
    required String link,
    required String voucherType,
    String? voucherPrefix,
  }) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String dateF = formatter.format(dateFrom);
    String dateT = formatter.format(dateTo);

    String url =
        "${getBaseURL()}$link&fromdate=$dateF&todate=$dateT&limit=1000&offset=0&Voucher_Type=$voucherType";
    // String url =
    //     "${baseURL}sales_order_webservice.php?action=getvoucherlistbydate&fromdate=$dateF&todate=$dateT&limit=1000&offset=0 ";

    if (voucherPrefix != null) {
      url += '&Voucher_Prefix=$voucherPrefix';
    }

    print("listurl : $url");
    String dBName = getDBName();
    Dio dio = Dio(BaseOptions(headers: {'dbname': dBName}));
    List data = [];
    Response response;
    try {
      response = await dio.get(url);
      print(response.data);
      data = response.data['data'];
    } catch (e) {
      print(e.toString());
      return [];
    }

    print('Data : $data');
    return data;
  }

  static Future<dynamic> getAllLedgers({DateTime? lastUpdated}) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String dateF = formatter.format(lastUpdated!);
    String fullURl =
        "${getBaseURL()}ledger_webservice.php?action=getAllLedgersNew&timestamp=$dateF"; //&timestamp=$dateF

    // print('Url for Led : $fullURl');
    dynamic data;
    Response? response;
    try {
      String dBName = getDBName();
      // Hive.box('settings').get('DBName');
      Dio dio = Dio(); //BaseOptions(headers: {'dbname': dBName}));
      dio.options.headers['dbname'] = dBName;
      response = await dio.get(
        fullURl,
        // headers: {"Accept": "application/json"},
      );

      // data = json.decode(response.body);
      // print('doen');
      data = response.data;
      // print('led data (from Webservice) : $data');
    } catch (ex) {
      print('Ledgers Error $fullURl');
      print(ex.toString());
      return false;
    }
    if (data['success'] == "1") {
      return data['data'];
    } else {
      return false;
    }
  }

  static Future<dynamic> getAllEmployees({DateTime? lastUpdated}) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String dateF = formatter.format(lastUpdated!);
    String fullURl =
        "${getBaseURL()}masters_webservice.php?action=getAllEmployees&timestamp=$dateF";

    print('Url : $fullURl');
    dynamic data;
    try {
      // print('DBNAME : ${Hive.box('settings').get('DBName')}');
      String dBName = getDBName();
      Dio dio = Dio(BaseOptions(headers: {'dbname': dBName}));
      final Response response = await dio.get(
        fullURl,
        // headers: {"Accept": "application/json"},
      );
      // data = json.decode(response.body);
      data = response.data;
      // print('Emp data (Webservice) : $data');
    } catch (ex) {
      print(ex.toString());
      return false;
    }
    if (data['success'] == "1") {
      return data['data'];
    } else {
      return false;
    }
  }

  static Future<dynamic> getAllUserGroups({DateTime? lastUpdated}) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String dateF = formatter.format(lastUpdated!);
    String fullURl =
        "${getBaseURL()}masters_webservice.php?action=getAllUserGroups&timestamp=$dateF";

    print('Url : $fullURl');
    dynamic data;
    try {
      print('DBNAME : ${Hive.box('settings').get('DBName')}');
      String dBName = getDBName();
      Dio dio = Dio(BaseOptions(headers: {'dbname': dBName}));
      final Response response = await dio.get(
        fullURl,
        // headers: {"Accept": "application/json"},
      );
      // data = json.decode(response.body);
      data = response.data;
      // print('Emp data (Webservice) : $data');
    } catch (ex) {
      print(ex.toString());
      return false;
    }
    if (data['success'] == "1") {
      return data['data'];
    } else {
      return false;
    }
  }

  static Future<dynamic> getAllPriceList({DateTime? lastUpdated}) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String dateF = formatter.format(lastUpdated!);
    String fullURl =
        "${getBaseURL()}masters_webservice.php?action=getAllPriceLists&timestamp=$dateF";

    // print('Url : $fullURl');
    dynamic data;
    try {
      // print('DBNAME : ${Hive.box('settings').get('DBName')}');
      String dBName = getDBName();
      Dio dio = Dio(BaseOptions(headers: {'dbname': dBName}));
      final Response response = await dio.get(
        fullURl,
        // headers: {"Accept": "application/json"},
      );
      // data = json.decode(response.body);
      data = response.data;
      // print('Price List data (Webservice) : $data');
    } catch (ex) {
      print(ex.toString());
      return false;
    }
    if (data['success'] == "1") {
      return data['data'];
    } else {
      return false;
    }
  }

  static Future<dynamic> getAllGodowns({DateTime? lastUpdated}) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String dateF = formatter.format(lastUpdated!);
    String fullURl =
        "${getBaseURL()}masters_webservice.php?action=getAllGodowns&timestamp=$dateF";

    print('Url : $fullURl');
    dynamic data;
    Response? response;
    try {
      // print('DBNAME : ${Hive.box('settings').get('DBName')}');
      String dBName = getDBName();
      Dio dio = Dio(); //BaseOptions(headers: {'dbname': dBName}));
      dio.options.headers['dbname'] = dBName;
      response = await dio.get(
        fullURl,
        // headers: {"Accept": "application/json"},
      );
      // data = json.decode(response.body);
      data = response.data;
    } catch (ex) {
      print('Godown Error : $ex');
      return false;
    }

    return data['data'];
  }

  static Future<dynamic> getAllUOM({DateTime? lastUpdated}) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String dateF = formatter.format(lastUpdated!);
    String fullURl =
        "${getBaseURL()}masters_webservice.php?action=getAllUOM&offset=0&limit=10000&timestamp=$dateF";

    // print('Url : $fullURl');
    dynamic data;
    Response? response;
    try {
      //     {'action': 'getAllLedgers'});
      String dBName = getDBName();
      // Hive.box('settings').get('DBName');
      Dio dio = Dio(); //BaseOptions(headers: {'dbname': dBName}));
      dio.options.headers['dbname'] = dBName;
      response = await dio.get(
        fullURl,
        // headers: {"Accept": "application/json"},
      );
      // data = json.decode(response.body);
      // print(response.data);
      data = response.data;
      // print('UOM data $data');
    } catch (ex) {
      print(fullURl);
      print('UOM Fetch Error ${ex.toString()}');
      return false;
    }

    return data['data'];
  }

  static Future<dynamic> getAccountgroups({DateTime? lastUpdated}) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String dateF = formatter.format(lastUpdated!);
    String fullURl =
        "${getBaseURL()}masters_webservice.php?action=getAllAccountGroups&timestamp=$dateF";

    print('GetUrl : $fullURl');
    // Dio dio = new Dio();
    // Response response = await dio.get(fullURl);
    dynamic data;
    try {
      String dBName = getDBName();
      Dio dio = Dio(); //BaseOptions(headers: {'dbname': dBName}));
      dio.options.headers['dbname'] = dBName;
      final Response response = await dio.get(
        fullURl,
        // headers: {"Accept": "application/json"},
      );
      // data = json.decode(response.body);
      data = response.data;
      // print(data);
    } catch (ex) {
      print('Error L: ${ex.toString()}');
      return false;
    }
    return data['data'];
  }

  static Future<dynamic> getAllInventoryGroups({DateTime? lastUpdated}) async {
    // String invLink = "$ip/inventory_webservice.php?action=";
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String dateF = formatter.format(lastUpdated!);
    print('Fetch ItemGroups');
    String invLink = "${getBaseURL()}inventory_webservice.php?action=";
    String fullURl = '${invLink}getAllGroups&timestamp=$dateF';
    print('Item Groups Url : $fullURl');

    dynamic data;
    try {
      String dBName = getDBName();
      Dio dio = Dio(); //BaseOptions(headers: {'dbname': dBName}));
      dio.options.headers['dbname'] = dBName;
      dio.options.headers['Content-Type'] = 'application/json';
      // await cli.get(fullURl);
      final Response response = await dio
          .get(
            fullURl,
            // headers: {"Accept": "application/json"},
          )
          .timeout(const Duration(
            seconds: 10,
          ));
      // data = json.decode(response.body);
      data = response.data;
      // print('Inv grp : $data');
    } catch (ex) {
      print('Inv Group : $fullURl');
      print('Inv Group fetch error caught : $ex}');
      return '$ex$fullURl is the link';
    }
    if (data['success'] == 1 || data['success'] == '1') {
      return data['data'];
    } else {
      return false;
    }
  }

  static Future<dynamic> getAllInventoryItems(
      {required DateTime lastUpdatedTimestamp}) async {
    // print('DT : $lastUpdatedTimestamp');
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String dateF = formatter.format(lastUpdatedTimestamp);
    String fullURl =
        "${getBaseURL()}inventory_webservice.php?action=getAllItemsNew&timestamp=$dateF";

    print('Url : $fullURl');
    // print('123');
    dynamic data;
    Response? response;
    try {
      String dBName = getDBName();
      // Hive.box('settings').get('DBName');
      Dio dio = Dio(BaseOptions(headers: {'dbname': dBName}));

      response = await dio.get(
        fullURl,
        // headers: {"Accept": "application/json"},
      );

      // data = json.decode(response.body);
      // print(response.data);
      data = response.data;
      // print('allitems ${data['data']}');
    } catch (ex) {
      print('Inventory Error');
      print('Inventory Error Status ${response?.statusCode}');
      print(ex.toString());
      return false;
    }
    if (data['success'] == 1 || data['success'] == '1') {
      return data['data'];
    } else {
      return false;
    }
  }

  static Future<dynamic> getLedgerBalance(
      String ledgerID, DateTime date) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String dateStr = formatter.format(date);
    String url =
        "${getBaseURL()}masters_webservice.php?action=getLedgerBalance&date=$dateStr&ledger_id=$ledgerID";

    print("url : $url");

    String dBName = getDBName();
    Dio dio = Dio(BaseOptions(headers: {'dbName': dBName}));
    dynamic val;
    Response response;
    try {
      response = await dio.post(url);
      print(response.data['data']);
      val = double.parse(response.data['data']['Balance']);

      print('Closing : $val');
    } catch (e) {
      print('Link : $url');
      print(e.toString());

      // return response.statusCode;
      return null;
    }

    return val;
  }

  Future<dynamic> getQCList({
    required DateTime date,
  }) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String dateStr = formatter.format(date);
    String url =
        "${getBaseURL()}qc_webservice.php?action=getQCListByDate&fromDate=$dateStr";

    print('QC URL : $url');

    String dBName = getDBName();
    Dio dio = Dio(BaseOptions(headers: {'dbname': dBName}));

    Response response;
    try {
      response = await dio.get(url);
    } catch (e) {
      return false;
    }

    return response.data;
  }

  Future<bool> saveQcEntry({required Map data}) async {
    String url = "${getBaseURL()}qc_webservice.php?action=upsertEntry";

    print('QC URL : $url');

    String dBName = getDBName();
    Dio dio = Dio(BaseOptions(headers: {'dbname': dBName}));

    Response? response;
    try {
      response = await dio.post(url, data: (data));
    } catch (e) {
      print(response);
      print('Save Qc Error : ${e.toString()}');
      return false;
    }
    return true;
  }

  static Future<dynamic> getUIConfig() async {
    String url = "https://switch1.org:9091/uiconfig/readall";

    print('Config URL : $url');

    String dbName = getDBName();

    Dio dio = Dio();

    Response? response;
    try {
      response = await dio.post(
        url,
      );

      dynamic data = response.data;
      return data;
    } catch (e) {
      print(response);
      print('UI fetch Error : ${e.toString()}');
      return false;
    }
  }

  static Future<dynamic> getUIResult({
    required List<String> qry,
  }) async {
    String url = "https://www.algoray.in:9091/execute-sql-query";

    print(' URL : $url');

    String dbName = getDBName();
    // getDBName();
    Dio dio = Dio(BaseOptions(
      headers: {
        'dbname': dbName,
      },
      receiveDataWhenStatusError: true,
    ));

    List qList = qry;

    Map body = {
      'query': qList,
      'type': 'extract',
    };
    // print('Body : ${jsonEncode(body)}');
    Response? response;
    try {
      response = await dio.post(
        url,
        data: body,
      );
      // print('Response : ${response.data}');
      List data = response.data;
      // if (data['error'] != null) {
      //   print('Error');
      //   return false;
      // }
      // print(data);
      return data[0];
    } catch (e) {
      print(response?.statusCode.toString());
      print('UI result Error : ${e.toString()}');
      return false;
    }
  }

  static Future<dynamic> getDashboard(String vPref) async {
    String fullURl =
        '${getBaseURL()}reports_webservice.php?action=get_shift_details';

    print('GetUrl : $fullURl');
    // Dio dio = new Dio();
    // Response response = await dio.get(fullURl);
    dynamic data;
    Response? response;
    try {
      String dBName = getDBName();
      Dio dio = Dio();
      dio.options.headers['dbname'] = dBName;
      dio.options.headers['Content-Type'] = 'application/json';

      response = await dio.get(
        fullURl,
        // headers: {"Accept": "application/json"},
      );
      // data = json.decode(response.body);
      data = response.data;
      // print(data);
    } catch (ex) {
      print('Error L: ${ex.toString()}');
      print('REsp : ${response?.data}');
      return false;
    }
    return data['data'];
  }

  static Future<dynamic> getAdminDashboard({
    List<String> dbnamesList = const <String>[],
    required DateTime fromDate,
    required DateTime toDate,
  }) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String fullURl =
        '${getBaseURL()}reports_webservice.php?action=sales_of_multiple_dbs&fromdate=${formatter.format(fromDate)}&todate=${formatter.format(toDate)}';

    print('GetUrl : $fullURl');
    // Dio dio = new Dio();
    // Response response = await dio.get(fullURl);
    dynamic data;
    Response? response;
    try {
      String dBName = getDBName();
      Dio dio = Dio();
      dio.options.headers['dbname'] = dBName;
      dio.options.headers['Content-Type'] = 'application/json';
      print(jsonEncode(dbnamesList));
      response = await dio.post(
        fullURl,
        // headers: {"Accept": "application/json"},
        data: dbnamesList,
      );
      // data = json.decode(response.body);
      data = response.data;
      // print(data);
    } catch (ex) {
      print('Error L: ${ex.toString()}');
      print('REsp : ${response?.data}');
      return false;
    }
    return data['data'];
  }

  static Future getShiftValues(String vPref, int empID) async {
    String fullURl =
        '${getBaseURL()}shift_webservice.php?action=get_shift_data&Voucher_Prefix=$vPref&emp_id=$empID';

    print('GetUrl : $fullURl');
    String dBName = getDBName();
    Dio dio = Dio();

    dio.options.headers['dbname'] = dBName;
    dynamic data;
    Response response;
    try {
      String dBName = getDBName();

      final Response response = await dio.get(
        fullURl,
        // headers: {"Accept": "application/json"},
      );
      // data = json.decode(response.body);
      data = response.data;
    } catch (ex) {
      print('Error L: ${ex.toString()}');
      return false;
    }

    return data['Data'];
  }

  static Future saveShiftData(Map shiftData) async {
    String fullURl = '${getBaseURL()}shift_webservice.php?action=upsertShift';

    print('GetUrl : $fullURl');
    print(' Type : ${shiftData.runtimeType} Data : ${jsonEncode(shiftData)}');

    dynamic data;
    try {
      String dBName = getDBName();
      Dio dio = Dio();

      dio.options.headers['dbname'] = dBName;

      final Response response = await dio.post(
        fullURl,
        data: jsonEncode(shiftData),
        // headers: {"Accept": "application/json"},
      );
      // data = json.decode(response.body);
      data = response.data;
      // print(data);
    } catch (ex) {
      print('Error L: ${ex.toString()}');
      return false;
    }
    return data['data'];
  }

  static Future<dynamic> getReportList({
    required String link,
    required DateTime dateFrom,
    required DateTime dateTo,
    int offset = 0,
    int limit = 50,
    String godownID = '',
    Map? map,
  }) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String dateF = formatter.format(dateFrom);
    String dateT = formatter.format(dateTo);
    String godown = godownID.isNotEmpty ? '&godown=$godownID' : '';
    String args = '';
    if (map != null) {
      for (var element in map.keys) {
        print('elem : $element ${map[element]}');
        args += '&$element=${map[element]}';
      }
    }

    String url =
        '${getBaseURL()}$link&fromdate=$dateF&todate=$dateT&limit=1000&offset=0$args$godown&show0Stock=1';

    String dBName = getDBName();
    Dio dio = Dio();

    dio.options.headers['dbname'] = dBName;

    print("url : $url : $dBName");

    // List data = [];

    late Response response;
    try {
      response = await dio.get(url);
      // print(response.data);
      // data = response.data['data'];
      return response.data['data'];
    } catch (e) {
      print('at cs web : ${e.toString()}');
      print('Url : $url');
      return null;
    }
  }

  static Future<dynamic> getQueryResult({
    required String link,
    Map? map,
  }) async {
    String args = '';
    if (map != null) {
      for (var element in map.keys) {
        print('elem : $element ${map[element]}');
        args += '&$element=${map[element]}';
      }
    }

    String url = '${getBaseURL()}$link$args';

    String dBName = getDBName();
    Dio dio = Dio();

    dio.options.headers['dbname'] = dBName;

    late Response response;
    try {
      response = await dio.get(url);
      if (response.data['success'] == "1") {
        return response.data['data'];
      } else {
        return false;
      }
    } catch (e) {
      print('Error @ getQueryResult : ${e.toString()}');
      print('Url : $url');
      return null;
    }
  }

  static Future<dynamic> getReportList1({
    required String link,
    DateTime? dateFrom,
    DateTime? dateTo,
    int offset = 0,
    int limit = 50,
    Map? map,
  }) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String dateF = dateFrom != null ? formatter.format(dateFrom) : '';
    String dateT = dateTo != null ? formatter.format(dateTo) : '';

    String args = '';
    if (map != null) {
      for (var element in map.keys) {
        print('elem : $element ${map[element]}');
        args += '&$element=${map[element]}';
      }
    }

    String url = '${getBaseURL()}$link$dateF$dateT&limit=1000&offset=0$args';

    String dBName = getDBName();
    Dio dio = Dio();

    dio.options.headers['dbname'] = dBName;

    print("url : $url : $dBName");

    // List data = [];

    late Response response;
    try {
      response = await dio.get(url);
      // print(response.data);
      // data = response.data['data'];
      return response.data['data'];
    } catch (e) {
      print('at cs web : ${e.toString()}');
      print('Url : $url');
      return null;
    }
  }

  static Future<dynamic> getXCustomerBalance(
      String ledID, DateTime date) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String dateF = formatter.format(date);
    String fullURl =
        '${getBaseURL()}reports_webservice.php?action=customer_balance_water&ledger_id=$ledID&date=$dateF';

    print('GetUrl : $fullURl');
    // Dio dio = new Dio();
    // Response response = await dio.get(fullURl);
    dynamic data;
    try {
      String dBName = getDBName();
      Dio dio = Dio();

      dio.options.headers['dbname'] = dBName;

      final Response response = await dio.get(
        fullURl,
        // headers: {"Accept": "application/json"},
      );
      // data = json.decode(response.body);
      data = response.data;
      // print(data);
    } catch (ex) {
      print('Error L: ${ex.toString()}');
      return false;
    }
    return data['data'];
  }

  static Future<dynamic> getWaterDashboard(
      DateTime date, String vPref, String gdID) async {
    String fullURl =
        '${getBaseURL()}shift_webservice.php?action=get_shift_data&Voucher_Prefix=$vPref';

    print('GetUrl : $fullURl');
    // Dio dio = new Dio();
    // Response response = await dio.get(fullURl);
    dynamic data;
    try {
      String dBName = getDBName();
      Dio dio = Dio();

      dio.options.headers['dbname'] = dBName;

      final Response response = await dio.get(
        fullURl,
        // headers: {"Accept": "application/json"},
      );
      // data = json.decode(response.body);
      data = response.data;
      // print(data);
    } catch (ex) {
      print('Error L: ${ex.toString()}');
      return false;
    }
    return data['Data'];
  }

  static Future<dynamic> getLedgerDashboard(
      String ledID, DateTime dateNow) async {
    String fullURl =
        '${getBaseURL()}shift_webservice.php?action=get_shift_data&led_id=$ledID';

    print('GetUrl : $fullURl');
    // Dio dio = new Dio();
    // Response response = await dio.get(fullURl);
    dynamic data;
    try {
      String dBName = getDBName();
      Dio dio = Dio();

      dio.options.headers['dbname'] = dBName;

      final Response response = await dio.get(
        fullURl,
        // headers: {"Accept": "application/json"},
      );
      // data = json.decode(response.body);
      data = response.data;
      // print(data);
    } catch (ex) {
      print('Error L: ${ex.toString()}');
      return false;
    }
    return data['Data'];
  }

  static Future<dynamic> getWaterRoute(int empID, String vPref) async {
    String fullURl =
        '${getBaseURL()}reports_webservice.php?action=water_dashboard&salesman_id=$empID&Voucher_Prefix=$vPref';

    print('GetUrl : $fullURl');
    // Dio dio = new Dio();
    // Response response = await dio.get(fullURl);
    dynamic data;
    try {
      String dBName = getDBName();
      Dio dio = Dio();

      dio.options.headers['dbname'] = dBName;

      final Response response = await dio.get(
        fullURl,
        // headers: {"Accept": "application/json"},
      );
      // data = json.decode(response.body);
      data = response.data;
      print('Water Dash : $data');
    } catch (ex) {
      print('Error L: ${ex.toString()}');
      return false;
    }
    return data['data'];
  }

  static Future<dynamic> getClosingstockByGd(
    String godown,
    DateTime dateFrom,
    DateTime dateTo,
  ) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String dateF = formatter.format(dateFrom);
    String dateT = formatter.format(dateTo);
    String url =
        "${getBaseURL()}reports_webservice.php?action=closing_stock&fromdate=$dateF&todate=$dateT&limit=1000&offset=0&godown=$godown&show0Stock=1";

    print("url : $url");

    String dBName = getDBName();
    Dio dio = Dio();

    dio.options.headers['dbname'] = dBName;
    dynamic val;
    Response response;
    try {
      response = await dio.post(url);
      print(response.data['data']);
      return response.data;
    } catch (e) {
      print(e.toString());
      // return response.statusCode;
      return null;
    }
  }

  static Future<dynamic> saveEmployee({
    required final EmployeeHiveModel emp,
  }) async {
    // String url = '${baseURL}sales_order_webservice.php?action=upsertSalesOrder';

    String fullURl =
        '${getBaseURL()}masters_webservice.php?action=upsertEmployee&sendToOtherDBs=0';

    print("url : $fullURl");
    // print('BODY : ${voucher.toJsonTrans()}');
    Response? response;
    // print('Item : ${item.toJson()}');

    Map m = emp.toMap();
    m["dbNames"] = ["aawater_test", "adukkala"];
    print(' jBODY : ${jsonEncode(m)}');
    // print(voucher.toMapForTransTest()['ledgersList']);
    try {
      String dBName = getDBName();
      // Hive.box('settings').get('DBName');
      Dio dio = Dio();
      dio.options.headers['dbname'] = dBName;

      response = await dio.post(fullURl, data: m);
    } catch (e) {
      print('Employee Error --  Web Service : ${e.toString()}');
      return {
        "result": {'Status': 'Failed'}
      };
    }
    return response.data;
  }

  static Future getAllContacts({DateTime? lastUpdated}) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String dateF = formatter.format(lastUpdated!);
    print("weServicestart");
    var url =
        "${getBaseURL()}/address_book_webservice.php?action=getAllContacts&lastUpdated=$dateF";
    try {
      print("URl : $url");
      String dBName = getDBName();
      Dio dio = Dio();

      dio.options.headers['dbname'] = dBName;
      var response = await dio.get(url);
      print('api call started');
      if (response.statusCode == 200) {
        final result = response.data;
        // var finalresult = allAddressModelFromJson(jsonEncode(result["data"]));
        // print(result);
        return result;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<ContactsDataModel?> getContactByNumber(String number) async {
    print("weServicestart");
    var url =
        "${WebservicePHPHelper.getBaseURL()}/address_book_webservice.php?action=getAddressByPhone&phone=$number";

    try {
      print("weServicetry : $url");
      String dBName = getDBName();
      Dio dio = Dio();

      dio.options.headers['dbname'] = dBName;
      var response = await dio.get(url);

      if (response.statusCode == 200) {
        // log('api call 200');
        final result = response.data;
        ContactsDataModel finalresult =
            ContactsDataModel.fromMap(result['data']);

        // print(finalresult.ContactName);
        // log('api call ok');
        return finalresult;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      print(e);
    }
    return ContactsDataModel.fromJson('{}');
  }

  static Future saveContact(ContactsDataModel contact) async {
    print("weServicestart");

    String fullURl =
        '${getBaseURL()}address_book_webservice.php?action=upsertAddress';

    print("url : $fullURl");
    // print('BODY : ${voucher.toJsonTrans()}');
    Response? response;
    // print('Item : ${item.toJson()}');

    Map m = contact.toMap();

    print(' jBODY : ${jsonEncode(m)}');
    // print(voucher.toMapForTransTest()['ledgersList']);
    try {
      String dBName = getDBName();
      // Hive.box('settings').get('DBName');
      Dio dio = Dio();
      dio.options.headers['dbname'] = dBName;

      response = await dio.post(fullURl, data: m);
    } catch (e) {
      print('Employee Error --  Web Service : ${e.toString()}');
      return {
        "result": {'Status': 'Failed'}
      };
    }
    return response.data;
  }

  static Future getLedgerMaster({required String ledID}) async {
    String url =
        "${getBaseURL()}masters_webservice.php?action=getLedgerById&ledger_id=$ledID";
    print("url : $url");
    try {
      String dBName = getDBName();
      Dio dio = Dio();

      dio.options.headers['dbname'] = dBName;
      var response = await dio.get(url);
      return response;
    } catch (e) {
      print(e);
    }
  }

  static Future getNextVoucherNumber(
      String? voucherType, String? voucherPrefix) async {
    String url =
        "${getBaseURL()}transactions_webservice.php?action=getNextVoucherNo&Voucher_Type=$voucherType&Voucher_Prefix=$voucherPrefix";
    print("url : $url");
    try {
      String dBName = getDBName();
      Dio dio = Dio();
      dio.options.headers['dbname'] = dBName;
      var response = await dio.get(url);
      print(response.data['Voucher_No']);
      return response.data['Voucher_No'];
    } catch (e) {
      print('Error URL : $url');
      print(e);
      return null;
    }
  }

  Future getBillsAvailable({
    required DateTime date,
  }) async {
    String url =
        "${getBaseURL()}masters_webservice.php?action=getBillwiseMappings";
    print("url : $url");
    try {
      String dBName = getDBName();
      Dio dio = Dio();
      dio.options.headers['dbname'] = dBName;
      var response = await dio.get(url);
      return response;
    } catch (e) {
      print('Error URL : $url');
      print(e);
    }
  }

  Future getBatchesListAvaialble({
    required String itemID,
    required DateTime dateTime,
    String? voucherNo = '0',
    String? voucher_pref = '',
    String? voucher_type = '',
    String? godown_id = '%',
  }) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String dateF = formatter.format(dateTime);
    String url =
        "${getBaseURL()}masters_webservice.php?action=getBatchwiseEntries&item_id=$itemID";
    url +=
        "&voucher_date=$dateF&voucher_no=$voucherNo&voucher_pref=$voucher_pref&voucher_type=$voucher_type&godown_id=$godown_id";
    print("url : $url");
    try {
      String dBName = getDBName();
      Dio dio = Dio();
      dio.options.headers['dbname'] = dBName;
      var response = dio.get(url);
      return response;
    } catch (e) {
      print('Error URL : $url');
      print(e);
    }
  }

  static Future<dynamic> getCurrentOrders({
    String vPrefix = '%',
  }) async {
    String url =
        "${getBaseURL()}transactions_webservice.php?action=getPendingOrders&Voucher_Prefix=$vPrefix&Voucher_Type=${GMVoucherTypes.SalesOrder}";

    print('Current ORders : $url');

    String dBName = getDBName();
    Dio dio = Dio(BaseOptions(headers: {'dbname': dBName}));

    Response response;
    try {
      response = await dio.get(url);
    } catch (e) {
      return false;
    }

    return response.data;
  }
}
