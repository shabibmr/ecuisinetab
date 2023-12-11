// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'inventory_item_detail_bloc.dart';

enum ItemDetailStatus {
  init,
  ready,
}

enum FetchStatus {
  init,
  reading,
  ready,
  empty,
  error,
}

class InventoryItemDetailState extends Equatable {
  const InventoryItemDetailState({
    this.item,
    required this.status,
    this.showBatchEditor,
    this.type,
    this.batchFetchStatus,
  });

  final InventoryItemDataModel? item;

  final ItemDetailStatus status;

  final bool? showBatchEditor;

  final TransactionType? type;

  final FetchStatus? batchFetchStatus;

  @override
  List<Object?> get props => [
        item,
        status,
        showBatchEditor,
        type,
        batchFetchStatus,
      ];

  InventoryItemDetailState copyWith({
    InventoryItemDataModel? item,
    ItemDetailStatus? status,
    bool? showBatchEditor,
    TransactionType? type,
    FetchStatus? batchFetchStatus,
  }) {
    return InventoryItemDetailState(
      item: item ?? this.item,
      status: status ?? this.status,
      showBatchEditor: showBatchEditor ?? this.showBatchEditor,
      type: type ?? this.type,
      batchFetchStatus: batchFetchStatus ?? this.batchFetchStatus,
    );
  }
}
