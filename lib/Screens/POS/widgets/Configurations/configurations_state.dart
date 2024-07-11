// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'configurations_bloc.dart';

class ConfigurationsState extends Equatable {
  const ConfigurationsState({
    this.allowWaiterChange,
    this.allowSalesInvoice,
    this.serverIP,
    this.dBName,
    this.voucherPref,
    this.printerName,
    this.ready,
    this.arabic,
    this.defaultPriceListID,
    this.endpoint,
  });

  final String? serverIP;
  final String? endpoint;
  final String? dBName;
  final String? voucherPref;
  final String? printerName;
  final bool? ready;
  final bool? arabic;
  final bool? allowWaiterChange;
  final bool? allowSalesInvoice;
  final int? defaultPriceListID;

  @override
  List<Object?> get props {
    return [
      serverIP,
      endpoint,
      dBName,
      voucherPref,
      printerName,
      ready,
      arabic,
      allowWaiterChange,
      allowSalesInvoice,
      defaultPriceListID,
    ];
  }

  ConfigurationsState copyWith({
    String? serverIP,
    String? endpoint,
    String? dBName,
    String? voucherPref,
    String? printerName,
    bool? ready,
    bool? arabic,
    bool? allowWaiterChange,
    bool? allowSalesInvoice,
    int? defaultPriceListID,
  }) {
    return ConfigurationsState(
      serverIP: serverIP ?? this.serverIP,
      endpoint: endpoint ?? this.endpoint,
      dBName: dBName ?? this.dBName,
      voucherPref: voucherPref ?? this.voucherPref,
      printerName: printerName ?? this.printerName,
      ready: ready ?? this.ready,
      arabic: arabic ?? this.arabic,
      allowWaiterChange: allowWaiterChange ?? this.allowWaiterChange,
      allowSalesInvoice: allowSalesInvoice ?? this.allowSalesInvoice,
      defaultPriceListID: defaultPriceListID ?? this.defaultPriceListID,
    );
  }
}
