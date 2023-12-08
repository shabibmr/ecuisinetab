part of 'pos_bloc.dart';

abstract class PosEvent extends Equatable {
  const PosEvent();

  @override
  List<Object> get props => [];
}

class GroupSelected extends PosEvent {
  final String groupID;

  GroupSelected({required this.groupID});
}
