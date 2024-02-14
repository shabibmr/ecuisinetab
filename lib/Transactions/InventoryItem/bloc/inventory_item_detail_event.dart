// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'inventory_item_detail_bloc.dart';

abstract class InventoryItemDetailEvent extends Equatable {
  const InventoryItemDetailEvent();

  @override
  List<Object> get props => [];
}

class SetItem extends InventoryItemDetailEvent {
  final InventoryItemDataModel item;

  SetItem({required this.item});
}

class SetIndex extends InventoryItemDetailEvent {
  final int index;

  const SetIndex({required this.index});
}

class SetItemTransactionType extends InventoryItemDetailEvent {
  final TransactionType type;

  SetItemTransactionType({required this.type});
}

class SetItemQuantity extends InventoryItemDetailEvent {
  final double qty;

  SetItemQuantity(this.qty);
}

class SetItemRate extends InventoryItemDetailEvent {
  final double rate;

  SetItemRate(this.rate);
}

class SetItemDiscountPercent extends InventoryItemDetailEvent {
  final double discPercent;

  SetItemDiscountPercent(this.discPercent);
}

class SetItemDiscountAmount extends InventoryItemDetailEvent {
  final double discAmount;

  SetItemDiscountAmount(this.discAmount);
}

class SetItemNarration extends InventoryItemDetailEvent {
  final String narration;

  SetItemNarration(this.narration);
}

class SetItemPriceLevel extends InventoryItemDetailEvent {
  final int priceID;

  const SetItemPriceLevel({required this.priceID});
}

class SetItemUOM extends InventoryItemDetailEvent {
  final UOMHiveMOdel uom;

  const SetItemUOM(this.uom);
}

class SetFromGodown extends InventoryItemDetailEvent {
  final String godownID;

  const SetFromGodown({required this.godownID});
}

class SetToGodown extends InventoryItemDetailEvent {
  final String godownID;

  const SetToGodown({required this.godownID});
}

class GetClosingStock extends InventoryItemDetailEvent {
  final DateTime toDate;

  GetClosingStock({required this.toDate});
}

class ItemUpdateBatch extends InventoryItemDetailEvent {
  final BatchDataModel batch;
  final int index;

  ItemUpdateBatch({
    required this.batch,
    required this.index,
  });
}

class BatchDeleteIndex extends InventoryItemDetailEvent {
  final int index;

  BatchDeleteIndex({
    required this.index,
  });
}

class ItemDetailShowBatchEditor extends InventoryItemDetailEvent {
  final bool show;

  ItemDetailShowBatchEditor({required this.show});
}

class ItemDetailFetchItemBatches extends InventoryItemDetailEvent {
  final DateTime date;
  final String vNo;

  final String vPref;
  ItemDetailFetchItemBatches({
    required this.date,
    required this.vNo,
    required this.vPref,
  });
}
