import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sql_exec_event.dart';
part 'sql_exec_state.dart';

class SqlExecBloc extends Bloc<SqlExecEvent, SqlExecState> {
  SqlExecBloc() : super(SqlExecInitial()) {
    on<SqlExecEvent>((event, emit) {});
  }
}
