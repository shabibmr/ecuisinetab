part of 'sql_exec_bloc.dart';

abstract class SqlExecState extends Equatable {
  const SqlExecState();

  @override
  List<Object> get props => [];
}

class SqlExecInitial extends SqlExecState {}
