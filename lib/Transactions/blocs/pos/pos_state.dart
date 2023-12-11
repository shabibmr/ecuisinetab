// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'pos_bloc.dart';

enum POSStatus {
  NEW,
  FetchingOrders,
  OrdersFetched,
  OrderFetchError,
  OrderSelected,
}

enum SyncStatus {
  ItemsLoading,
  ItemsLoaded,
}

class PosState extends Equatable {
  const PosState({
    required this.status,
    this.items,
    this.itemsLoadStaus,
    this.currentOrders,
    this.vID,
    this.vPrefix,
  });

  final POSStatus status;
  final List<InventoryItemHive>? items;
  final SyncStatus? itemsLoadStaus;
  final List<Map>? currentOrders;
  final String? vID;
  final String? vPrefix;

  @override
  List<Object?> get props => [status, items, itemsLoadStaus];

  PosState copyWith({
    POSStatus? status,
    List<InventoryItemHive>? items,
    SyncStatus? itemsLoadStaus,
    List<Map>? currentOrders,
    String? vID,
    String? vPrefix,
  }) {
    return PosState(
      status: status ?? this.status,
      items: items ?? this.items,
      itemsLoadStaus: itemsLoadStaus ?? this.itemsLoadStaus,
      currentOrders: currentOrders ?? this.currentOrders,
      vID: vID ?? this.vID,
      vPrefix: vPrefix ?? this.vPrefix,
    );
  }

  @override
  bool get stringify => true;
}
