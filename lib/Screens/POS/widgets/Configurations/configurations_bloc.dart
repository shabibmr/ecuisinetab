import 'dart:io';

import 'package:bloc/bloc.dart';
// import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:network_info_plus/network_info_plus.dart';

import '../../../../Login/constants.dart';

part 'configurations_event.dart';
part 'configurations_state.dart';

class ConfigurationsBloc
    extends Bloc<ConfigurationsEvent, ConfigurationsState> {
  ConfigurationsBloc() : super(ConfigurationsState()) {
    on<SetIPAddress>((event, emit) {
      emit(state.copyWith(ServerIP: event.str));
    });
    on<SetDbName>((event, emit) {
      emit(state.copyWith(DBName: event.str));
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
    on<SaveConfiguration>((event, emit) {
      Box sett = Hive.box(HiveTagNames.Settings_Hive_Tag);
      sett.put('url', state.serverIP);
      sett.put('DBName', state.dBName);
      sett.put('BillPrinter', state.printerName);
      sett.put('vPref', state.voucherPref);
      sett.put('isArabic', state.arabic);
    });
    on<ReadConfig>((event, emit) async {
      emit(state.copyWith(ready: false));
      // await getIPAddress();
      Box sett = Hive.box(HiveTagNames.Settings_Hive_Tag);
      print('Settings Read : ');
      emit(state.copyWith(
        ServerIP:
            sett.get('url', defaultValue: 'http://192.168.1.99/test_app_water'),
        DBName: sett.get('DBName', defaultValue: 'gmdb'),
        voucherPref: sett.get('vPref', defaultValue: 'A'),
        printerName: sett.get('BillPrinter', defaultValue: 'Counter'),
        arabic: sett.get('isArabic', defaultValue: false),
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
