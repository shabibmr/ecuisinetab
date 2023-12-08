import 'dart:convert';

import '../../Fetch_SQL/bloc/ReportsModel.dart';
import '../../../Webservices/webservicePHP.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

part 'fetch_sql_event.dart';
part 'fetch_sql_state.dart';

class FetchSqlBloc extends Bloc<FetchSqlEvent, FetchSqlState> {
  final Box uiBox;
  DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
  FetchSqlBloc({
    required this.uiBox,
  }) : super(FetchSqlState(
          status: FetchSQLStatus.init,
        )) {
    // To Send API request
    on<FetchSqlData>((event, emit) async {
      print('fetching data');
      emit(state.copyWith(status: FetchSQLStatus.fetching));
      print('sent fetching');

      String queryBuilt = queryBuilder();
      print('Q Built : $queryBuilt');

      try {
        final dataResponse =
            await WebservicePHPHelper.getUIResult(qry: [queryBuilt]);

        // print('dataResponse is ${dataResponse}');

        if (dataResponse == false) {
          emit(state.copyWith(
            status: FetchSQLStatus.error,
          ));
          return;
        }
        // print('Type : ${dataResponse.runtimeType}');
        // print('Size : ${dataResponse.length}');
        final List data = dataResponse['rows'];
        final List cols = dataResponse['columns'];
        // print('Data : ${data.runtimeType}');

        // (data[0] as Map).keys.forEach((element) {
        //   if (cols.contains(element)) {
        //     print('Col Name exisits : $element');
        //   }
        // });
        print('Hidden vals : ');
        state.hiddenCols.forEach((element) {
          print(element);
        });
        emit(
          state.copyWith(
            status: FetchSQLStatus.fetchCompleted,
            data: data,
            cols: cols,
          ),
        );
      } catch (e) {
        print('Err : ${e.toString()}');
        emit(state.copyWith(status: FetchSQLStatus.error, msg: e.toString()));
      }
    });
    //Set From Date
    on<SetFromDate>((event, emit) {
      DateTime toDate = state.toDate ?? event.fromDate!;
      print('Setting from date');
      // if (event.fromDate!.compareTo(state.toDate!) > 0) {
      //   toDate = event.fromDate!;
      // }

      emit(state.copyWith(
        fromDate: event.fromDate,
        toDate: toDate,
      ));

      print('Current from : ${state.fromDate}');
    });
    // Set TO Date
    on<SetToDate>((event, emit) {
      DateTime? fromDate = state.fromDate;
      if (fromDate != null) {
        if (fromDate.compareTo(event.toDate!) > 0) {
          fromDate = event.toDate;
        }
      }
      emit(state.copyWith(
        fromDate: fromDate,
        toDate: event.toDate,
      ));
    });

    on<SetReport>(
      (event, emit) {
        print('Setting report : #${event.reportID}');
        Map rMap = uiBox.get(event.reportID);

        Map? filter;
        DateTime? fromDate;
        DateTime? toDate;
        print(rMap);

        if (rMap['filters'] != null) {
          Map filterData = jsonDecode(rMap['filters']);

          List dates = filterData['dateTime'];

          filter = {};
          if (dates.contains('fromDateTime')) {
            fromDate = state.fromDate ?? DateTime.now();
            filter.addAll({'fromDateTime': formatter.format(fromDate)});
          }
          if (dates.contains('toDateTime')) {
            toDate = state.toDate ?? DateTime.now();
            filter.addAll({'toDateTime': formatter.format(toDate)});
          }
        }

        Map? displayOptions = jsonDecode(rMap['display_options']);
        List hidden = displayOptions?['Hide'] ?? [];

        int stretch = displayOptions?['stretch'] ?? -1;

        print('Hidden : $hidden');

        ReportDataModel rData = ReportDataModel(
          id: rMap['id'],
          moduleName: rMap['sub_type'] ?? '',
          displayOptions: jsonDecode(rMap['display_options']),
          filters: filter,
          query: rMap['query'],
          reportName: rMap['ui_name'],
          reportType: rMap['ui_type'],
          stretch: stretch,
        );

        emit(state.copyWith(
          hiddenCols: hidden,
          reportData: rData,
          fromDate: fromDate,
          toDate: toDate,
          status: FetchSQLStatus.reportDataSet,
        ));
      },
    );
    on<SetAdminDash>(
      (event, emit) async {
        emit(state.copyWith(status: FetchSQLStatus.fetching));

        try {
          final data = await WebservicePHPHelper.getAdminDashboard(
              dbnamesList: event.dbList,
              fromDate: state.fromDate!,
              toDate: state.toDate!);

          print('Data : $data');

          if (data == false) {
            emit(state.copyWith(
              status: FetchSQLStatus.error,
            ));
          } else {
            emit(state.copyWith(
              data: data,
              status: FetchSQLStatus.reportDataSet,
            ));
          }
        } catch (e) {
          print('Exception : $e');
          emit(state.copyWith(
            status: FetchSQLStatus.error,
          ));
        }
      },
    );
    on<SetDashboard>(
      (event, emit) async {
        emit(state.copyWith(status: FetchSQLStatus.fetching));

        try {
          final data = await WebservicePHPHelper.getDashboard('');

          print('Data : $data');

          if (data == false) {
            emit(state.copyWith(
              status: FetchSQLStatus.error,
            ));
          } else {
            emit(state.copyWith(
              data: data,
              status: FetchSQLStatus.reportDataSet,
            ));
          }
        } catch (e) {
          print('Exception : $e');
          emit(state.copyWith(
            status: FetchSQLStatus.error,
          ));
        }
      },
    );
  }

  String queryBuilder() {
    String qry = state.reportData!.query!;
    Map? filter = state.reportData!.filters;

    print(
        'filter Size : ${state.reportData?.filters?.length} from ${state.fromDate}');
    filter?.keys.forEach((key) {
      print('Key : $key val : ${filter[key]}');
      var val = filter[key];
      if (key == "fromDateTime") {
        val = formatter.format(state.fromDate!);
      } else if (key == "toDateTime") {
        val = formatter.format(state.toDate!);
      }
      qry = qry.replaceAll('\$$key', val);
    });

    qry = qry.replaceAll('\$trans_db.', '');
    qry = qry.replaceAll('\$master_db.', '');
    return qry;
  }
}
