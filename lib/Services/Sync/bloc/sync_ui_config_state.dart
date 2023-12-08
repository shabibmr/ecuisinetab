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
    required this.status,
    this.msg,
  });

  final SyncUiConfigStatus status;
  final String? msg;

  @override
  List<Object> get props => [status];

  SyncServiceState copyWith({
    SyncUiConfigStatus? status,
    String? msg,
  }) {
    return SyncServiceState(
      status: status ?? this.status,
      msg: msg ?? this.msg,
    );
  }
}
