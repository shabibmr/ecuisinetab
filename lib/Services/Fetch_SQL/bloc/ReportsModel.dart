// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ReportDataModel extends Equatable {
  final String? id;
  final String? widgetId;
  final String? reportName;
  final String? moduleName;
  final String? reportType;
  final Map? filters;
  final Map? displayOptions;
  final Map? redirectOptions;
  final String? query;
  final List? hidden;
  final int? stretch;

  ReportDataModel({
    this.id,
    this.widgetId,
    this.reportName,
    this.moduleName,
    this.reportType,
    this.filters,
    this.displayOptions,
    this.redirectOptions,
    this.query,
    this.hidden,
    this.stretch,
  });

  ReportDataModel copyWith({
    String? id,
    String? widgetId,
    String? reportName,
    String? moduleName,
    String? reportType,
    Map? filters,
    Map? displayOptions,
    Map? redirectOptions,
    String? query,
    List? hidden,
    int? stretch,
  }) {
    return ReportDataModel(
      id: id ?? this.id,
      widgetId: widgetId ?? this.widgetId,
      reportName: reportName ?? this.reportName,
      moduleName: moduleName ?? this.moduleName,
      reportType: reportType ?? this.reportType,
      filters: filters ?? this.filters,
      displayOptions: displayOptions ?? this.displayOptions,
      redirectOptions: redirectOptions ?? this.redirectOptions,
      query: query ?? this.query,
      hidden: hidden ?? this.hidden,
      stretch: stretch ?? this.stretch,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      widgetId,
      reportName,
      moduleName,
      reportType,
      filters,
      displayOptions,
      redirectOptions,
      query,
      hidden,
      stretch
    ];
  }
}
