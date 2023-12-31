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

  SetArabic({required this.isArabic});
}
