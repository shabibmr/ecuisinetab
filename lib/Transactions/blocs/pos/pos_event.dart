// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pos_bloc.dart';

abstract class PosEvent extends Equatable {
  const PosEvent();

  @override
  List<Object> get props => [];
}

class GroupSelected extends PosEvent {
  final String groupID;
  final int? index;

  const GroupSelected({required this.groupID, this.index});
}

class ItemsLoaded extends PosEvent {}

class ItemsLoading extends PosEvent {}

class ItemsLoadFailed extends PosEvent {
  final String? msg;

  const ItemsLoadFailed({this.msg});
}

class GroupsLoaded extends PosEvent {}

class GroupsLoading extends PosEvent {}

class GroupsLoadFailed extends PosEvent {
  final String? msg;

  const GroupsLoadFailed({this.msg});
}

class OrderSelected extends PosEvent {
  final String? voucherNo;
  final String? vPrefix;

  const OrderSelected({
    this.voucherNo,
    this.vPrefix,
  });
}

class OrderSent extends PosEvent {}

class FetchCurrentOrders extends PosEvent {}

class RefreshPOS extends PosEvent {}

class UpdateItem extends PosEvent {
  final String itemID;
  final double quantity;
  const UpdateItem({
    required this.itemID,
    required this.quantity,
  });
}
