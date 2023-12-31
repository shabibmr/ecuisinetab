// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'configurations_bloc.dart';

class ConfigurationsState extends Equatable {
  const ConfigurationsState({
    this.serverIP,
    this.dBName,
    this.voucherPref,
    this.printerName,
    this.ready,
    this.arabic,
  });

  final String? serverIP;
  final String? dBName;
  final String? voucherPref;
  final String? printerName;
  final bool? ready;
  final bool? arabic;

  @override
  List<Object?> get props =>
      [serverIP, dBName, voucherPref, printerName, ready, arabic];

  ConfigurationsState copyWith({
    String? ServerIP,
    String? DBName,
    String? voucherPref,
    String? printerName,
    bool? arabic,
    bool? ready,
  }) {
    return ConfigurationsState(
      serverIP: ServerIP ?? this.serverIP,
      dBName: DBName ?? this.dBName,
      voucherPref: voucherPref ?? this.voucherPref,
      printerName: printerName ?? this.printerName,
      ready: ready ?? this.ready,
      arabic: arabic ?? this.arabic,
    );
  }
}
