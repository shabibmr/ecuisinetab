// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'fetch_sql_bloc.dart';

enum FetchSQLStatus {
  init,
  reportDataSet,
  fetching,
  fetchCompleted,
  error,
}

class FetchSqlState extends Equatable {
  FetchSqlState({
    this.fromDate,
    this.toDate,
    required this.status,
    this.data,
    this.msg,
    this.reportData,
    this.cols,
    this.hiddenCols = const [],
  });

  final dynamic data;
  final List? cols;
  final FetchSQLStatus status;
  final String? msg;
  final ReportDataModel? reportData;

  final List hiddenCols;

  final DateTime? fromDate;
  final DateTime? toDate;

  @override
  List<Object?> get props {
    return [
      data,
      cols,
      status,
      msg,
      reportData,
      fromDate,
      toDate,
      hiddenCols,
    ];
  }

  FetchSqlState copyWith({
    dynamic? data,
    List? cols,
    FetchSQLStatus? status,
    String? msg,
    ReportDataModel? reportData,
    DateTime? fromDate,
    DateTime? toDate,
    List? hiddenCols,
  }) {
    return FetchSqlState(
      data: data ?? this.data,
      cols: cols ?? this.cols,
      status: status ?? this.status,
      msg: msg ?? this.msg,
      reportData: reportData ?? this.reportData,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      hiddenCols: hiddenCols ?? this.hiddenCols,
    );
  }
}
