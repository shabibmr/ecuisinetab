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
    this.tables,
    this.currentKOT,
    this.currentGroupID,
  });

  final POSStatus status;
  final List<InventoryItemHive>? items;
  final SyncStatus? itemsLoadStaus;
  final Map<String, dynamic>? currentOrders;
  final List<String>? tables;
  final String? vID;
  final String? vPrefix;
  final Map<String, double>? currentKOT;
  final String? currentGroupID;

  @override
  List<Object?> get props => [
        status,
        items,
        itemsLoadStaus,
        currentKOT,
        itemsLoadStaus,
        currentGroupID
      ];

  PosState copyWith({
    POSStatus? status,
    List<InventoryItemHive>? items,
    SyncStatus? itemsLoadStaus,
    Map<String, dynamic>? currentOrders,
    Map<String, double>? currentKOT,
    List<String>? tables,
    String? vID,
    String? vPrefix,
    String? currentGroupID,
  }) {
    return PosState(
      status: status ?? this.status,
      items: items ?? this.items,
      itemsLoadStaus: itemsLoadStaus ?? this.itemsLoadStaus,
      currentOrders: currentOrders ?? this.currentOrders,
      currentKOT: currentKOT ?? this.currentKOT,
      tables: tables ?? this.tables,
      vID: vID ?? this.vID,
      vPrefix: vPrefix ?? this.vPrefix,
      currentGroupID: currentGroupID ?? this.currentGroupID,
    );
  }
}
