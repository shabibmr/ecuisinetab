import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:network_info_plus/network_info_plus.dart';

import '../../../../Login/constants.dart';

part 'configurations_event.dart';
part 'configurations_state.dart';

class ConfigurationsBloc
    extends Bloc<ConfigurationsEvent, ConfigurationsState> {
  ConfigurationsBloc() : super(const ConfigurationsState()) {
    on<SetIPAddress>((event, emit) {
      emit(state.copyWith(serverIP: event.str));
    });
    on<SetDbName>((event, emit) {
      emit(state.copyWith(dBName: event.str));
    });
    on<SetPrinterName>((event, emit) {
      emit(state.copyWith(printerName: event.str));
    });
    on<SetVoucherPrefixConfig>((event, emit) {
      emit(state.copyWith(voucherPref: event.str));
    });
    on<SetArabic>((event, emit) {
      emit(state.copyWith(arabic: event.isArabic));
    });
    on<SetDefaultPriceListID>((event, emit) {
      emit(state.copyWith(defaultPriceListID: event.defaultPriceListId));
    });
    on<SaveConfiguration>((event, emit) {
      Box sett = Hive.box(HiveTagNames.Settings_Hive_Tag);
      sett.put(Config_Tag_Names.Server_IP_Tag, state.serverIP);

      sett.put(Config_Tag_Names.App_Endpoint_Tag, state.endpoint);
      sett.put(Config_Tag_Names.DBName_Tag, state.dBName);
      sett.put(Config_Tag_Names.Bill_Printer_Tag, state.printerName);
      sett.put(Config_Tag_Names.Voucher_Prefix_Tag, state.voucherPref);
      sett.put(Config_Tag_Names.Arabic_Lang_Tag, state.arabic);
      sett.put(
          Config_Tag_Names.Default_PriceList_Tag, state.defaultPriceListID);
    });
    on<ReadConfig>((event, emit) async {
      emit(state.copyWith(ready: false));
      // await getIPAddress();
      Box sett = Hive.box(HiveTagNames.Settings_Hive_Tag);
      emit(state.copyWith(
        serverIP: sett.get(Config_Tag_Names.Server_IP_Tag,
            defaultValue: HiveTagNames.Default_Server_IP),
        endpoint: sett.get(Config_Tag_Names.App_Endpoint_Tag,
            defaultValue: HiveTagNames.Default_endpoint),
        dBName: sett.get(Config_Tag_Names.DBName_Tag,
            defaultValue: HiveTagNames.Default_DB),
        voucherPref:
            sett.get(Config_Tag_Names.Voucher_Prefix_Tag, defaultValue: 'A'),
        printerName: sett.get(Config_Tag_Names.Bill_Printer_Tag,
            defaultValue: 'Counter'),
        arabic: sett.get(Config_Tag_Names.Arabic_Lang_Tag, defaultValue: false),
        defaultPriceListID: sett.get('Default_Pricelist_Id', defaultValue: 3),
        ready: true,
      ));
    });
  }

  // Future<String> getIPAddress() async {
  // var networkInfo = NetworkInfo();
  // String? wifiIP = await networkInfo.getWifiIP();
  // return wifiIP ?? 'Unknown IP';
  // }
}
