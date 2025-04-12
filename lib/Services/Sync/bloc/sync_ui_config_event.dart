part of 'sync_ui_config_bloc.dart';

abstract class SyncServiceEvent extends Equatable {
  const SyncServiceEvent();

  @override
  List<Object> get props => [];
}

class FetchUIConfigEvent extends SyncServiceEvent {
  const FetchUIConfigEvent();
}

class FetchItemsEvent extends SyncServiceEvent {
  const FetchItemsEvent();
}

class FetchItemGroupsEvent extends SyncServiceEvent {
  const FetchItemGroupsEvent();
}

class FetchLedgersEvent extends SyncServiceEvent {
  const FetchLedgersEvent();
}

class FetchAccGroupsEvent extends SyncServiceEvent {
  const FetchAccGroupsEvent();
}

class FetchUOMEvent extends SyncServiceEvent {
  const FetchUOMEvent();
}

class FetchEmployeesEvent extends SyncServiceEvent {
  const FetchEmployeesEvent();
}

class FetchGodownsEvent extends SyncServiceEvent {
  const FetchGodownsEvent();
}

class FetchAllMastersEvent extends SyncServiceEvent {
  const FetchAllMastersEvent();
}

class FetchPricesEvent extends SyncServiceEvent {
  const FetchPricesEvent();
}

class CheckServer extends SyncServiceEvent {
  const CheckServer();
}

class FetchContactsEvent extends SyncServiceEvent {
  const FetchContactsEvent();
}
