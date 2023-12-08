part of 'fetch_sql_bloc.dart';

abstract class FetchSqlEvent extends Equatable {
  const FetchSqlEvent();

  @override
  List<Object?> get props => [];
}

class FetchSqlData extends FetchSqlEvent {}

class SetFromDate extends FetchSqlEvent {
  SetFromDate({
    this.fromDate,
  });
  final DateTime? fromDate;
}

class SetToDate extends FetchSqlEvent {
  SetToDate({
    this.toDate,
  });
  final DateTime? toDate;
}

class SetReport extends FetchSqlEvent {
  final String reportID;

  SetReport({
    required this.reportID,
  });
}

class SetDashboard extends FetchSqlEvent {}

class SetAdminDash extends FetchSqlEvent {
  final List<String> dbList;

  SetAdminDash({required this.dbList});
}
