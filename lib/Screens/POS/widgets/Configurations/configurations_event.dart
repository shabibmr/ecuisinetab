part of 'configurations_bloc.dart';

sealed class ConfigurationsEvent extends Equatable {
  const ConfigurationsEvent();

  @override
  List<Object> get props => [];
}

class SaveConfiguration extends ConfigurationsEvent {}

class SetIPAddress extends ConfigurationsEvent {
  final String? str;

  SetIPAddress({this.str});
}

class SetEndPoint extends ConfigurationsEvent {
  final String? str;

  SetEndPoint({this.str});
}

class SetDbName extends ConfigurationsEvent {
  final String? str;

  SetDbName({this.str});
}

class SetVoucherPrefixConfig extends ConfigurationsEvent {
  final String? str;

  SetVoucherPrefixConfig({this.str});
}

class SetPrinterName extends ConfigurationsEvent {
  final String? str;

  SetPrinterName({this.str});
}

class ReadConfig extends ConfigurationsEvent {}

class SetArabic extends ConfigurationsEvent {
  final bool isArabic;

  const SetArabic({required this.isArabic});
}

class SetAllowWaiter extends ConfigurationsEvent {
  final bool isAllowWaiter;

  const SetAllowWaiter({required this.isAllowWaiter});
}

class SetAllowInovice extends ConfigurationsEvent {
  final bool allowSales;

  const SetAllowInovice({required this.allowSales});
}

class SetDefaultPriceListID extends ConfigurationsEvent {
  final int defaultPriceListId;
  const SetDefaultPriceListID({required this.defaultPriceListId});
}
