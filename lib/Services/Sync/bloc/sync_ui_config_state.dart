// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sync_ui_config_bloc.dart';

enum SyncUiConfigStatus {
  init,
  fetching,
  fetched,
  updated,
  error,
}

class SyncServiceState extends Equatable {
  const SyncServiceState({
    this.itemsSynced,
    this.invGroupsSynced,
    this.envSync,
    this.ledSync,
    required this.status,
    this.msg,
  });

  final SyncUiConfigStatus status;
  final String? msg;
  final bool? itemsSynced;
  final bool? invGroupsSynced;
  final bool? envSync;
  final bool? ledSync;

  @override
  List<Object> get props => [status];

  SyncServiceState copyWith({
    SyncUiConfigStatus? status,
    String? msg,
    bool? itemsSynced,
    bool? invGroupsSynced,
    bool? envSync,
    bool? ledSync,
  }) {
    return SyncServiceState(
      status: status ?? this.status,
      msg: msg ?? this.msg,
      itemsSynced: itemsSynced ?? this.itemsSynced,
      invGroupsSynced: invGroupsSynced ?? this.invGroupsSynced,
      envSync: envSync ?? this.envSync,
      ledSync: ledSync ?? this.ledSync,
    );
  }
}
