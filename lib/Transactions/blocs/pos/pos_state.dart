// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'pos_bloc.dart';

enum POSStatus {
  NEW,
}

enum ItemsLoadingStatus {
  ItemsLoading,
  ItemsLoaded,
}

class PosState extends Equatable {
  const PosState({
    required this.status,
    this.items,
    this.itemsLoadStaus,
  });

  final POSStatus status;
  final List<InventoryItemHive>? items;
  final ItemsLoadingStatus? itemsLoadStaus;

  @override
  List<Object?> get props => [status, items, itemsLoadStaus];

  PosState copyWith({
    POSStatus? status,
    List<InventoryItemHive>? items,
    ItemsLoadingStatus? itemsLoadStaus,
  }) {
    return PosState(
      status: status ?? this.status,
      items: items ?? this.items,
      itemsLoadStaus: itemsLoadStaus ?? this.itemsLoadStaus,
    );
  }

  @override
  bool get stringify => true;
}
