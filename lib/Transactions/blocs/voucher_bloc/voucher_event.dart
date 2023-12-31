// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'voucher_bloc.dart';

abstract class VoucherEvent extends Equatable {
  const VoucherEvent();

  @override
  List<Object?> get props => [];
}

class SetMainLedger extends VoucherEvent {
  final LedgerMasterDataModel? ledger;

  SetMainLedger({
    required this.ledger,
  });

  @override
  List<Object?> get props => [ledger];
}

class SetVoucherDate extends VoucherEvent {
  final DateTime voucherDate;

  SetVoucherDate({
    required this.voucherDate,
  });

  @override
  List<Object> get props => [voucherDate];
}

class SetVoucherSalesman extends VoucherEvent {
  final int salesmanID;

  SetVoucherSalesman({
    required this.salesmanID,
  });

  @override
  List<Object> get props => [salesmanID];
}

class SetAddedByID extends VoucherEvent {
  final int addedByID;

  SetAddedByID({
    required this.addedByID,
  });

  @override
  List<Object> get props => [addedByID];
}

class SetPriceList extends VoucherEvent {
  final int priceListID;

  SetPriceList({
    required this.priceListID,
  });

  @override
  List<Object> get props => [priceListID];
}

class SetNarration extends VoucherEvent {
  final String narration;

  SetNarration({
    required this.narration,
  });

  @override
  List<Object> get props => [narration];
}

class SaveVoucher extends VoucherEvent {
  SaveVoucher();

  @override
  List<Object> get props => [];
}

class VoucherRequestSave extends VoucherEvent {
  VoucherRequestSave();

  @override
  List<Object> get props => [];
}

class SetVoucherID extends VoucherEvent {
  final String voucherID;

  SetVoucherID({
    required this.voucherID,
  });

  @override
  List<Object> get props => [voucherID];
}

class SetVoucher extends VoucherEvent {
  final GeneralVoucherDataModel voucher;

  SetVoucher({
    required this.voucher,
  });

  @override
  List<Object> get props => [voucher];
}

class RefreshVoucher extends VoucherEvent {
  RefreshVoucher();

  @override
  List<Object> get props => [];
}

class SetTransactionType extends VoucherEvent {
  final TransactionType transactionType;

  SetTransactionType({
    required this.transactionType,
  });
}

class SetDiscountPercentage extends VoucherEvent {
  final double discountPercentage;

  SetDiscountPercentage({
    required this.discountPercentage,
  });

  @override
  List<Object> get props => [discountPercentage];
}

class SetDiscountAmount extends VoucherEvent {
  final double discountAmount;

  SetDiscountAmount({
    required this.discountAmount,
  });

  @override
  List<Object> get props => [discountAmount];
}

class SetEmptyVoucher extends VoucherEvent {
  final String voucherType;

  SetEmptyVoucher({
    required this.voucherType,
  });

  @override
  List<Object> get props => [voucherType];
}

class SetToGodownID extends VoucherEvent {
  final String toGodownID;

  SetToGodownID({
    required this.toGodownID,
  });

  @override
  List<Object> get props => [toGodownID];
}

class SetFromGodownID extends VoucherEvent {
  final String fromGodownID;

  SetFromGodownID({
    required this.fromGodownID,
  });

  @override
  List<Object> get props => [fromGodownID];
}

class SetCustomerAddress extends VoucherEvent {
  final String customerAddress;

  SetCustomerAddress({
    required this.customerAddress,
  });

  @override
  List<Object> get props => [customerAddress];
}

class SetCustomerPhoneNumber extends VoucherEvent {
  final String phoneNumber;

  SetCustomerPhoneNumber({
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [phoneNumber];
}

class SetCustomerName extends VoucherEvent {
  final String name;

  SetCustomerName({
    required this.name,
  });

  @override
  List<Object> get props => [name];
}

class SwitchReference extends VoucherEvent {
  final String newReference;

  SwitchReference({
    required this.newReference,
  });

  @override
  List<Object> get props => [newReference];
}

class RecalculateVoucher extends VoucherEvent {
  RecalculateVoucher();

  @override
  List<Object> get props => [];
}

class AddInventoryItem extends VoucherEvent {
  final InventoryItemDataModel inventoryItem;

  AddInventoryItem({
    required this.inventoryItem,
  });

  @override
  List<Object> get props => [inventoryItem];
}

class UpdateInventoryItemAtIndex extends VoucherEvent {
  final int index;
  final InventoryItemDataModel inventoryItem;

  UpdateInventoryItemAtIndex({
    required this.index,
    required this.inventoryItem,
  });

  @override
  List<Object> get props => [index, inventoryItem];
}

class RemoveInventoryItemAtIndex extends VoucherEvent {
  final int index;

  RemoveInventoryItemAtIndex({
    required this.index,
  });

  @override
  List<Object> get props => [index];
}

class AddLedger extends VoucherEvent {
  final LedgerMasterDataModel ledger;

  AddLedger({
    required this.ledger,
  });

  @override
  List<Object> get props => [ledger];
}

class UpdateLedgerAtIndex extends VoucherEvent {
  final int index;
  final LedgerMasterDataModel ledger;

  UpdateLedgerAtIndex({
    required this.index,
    required this.ledger,
  });

  @override
  List<Object> get props => [index, ledger];
}

class DeleteLedgerAtIndex extends VoucherEvent {
  final int index;

  DeleteLedgerAtIndex({
    required this.index,
  });

  @override
  List<Object> get props => [index];
}

class SetContact extends VoucherEvent {
  final ContactsDataModel contact;

  SetContact({
    required this.contact,
  });

  @override
  List<Object> get props => [contact];
}

class UpdateItemQty extends VoucherEvent {
  final num qty;
  final InventoryItemDataModel item;

  UpdateItemQty({
    required this.item,
    required this.qty,
  });
}

class FetchVoucher extends VoucherEvent {
  final String voucherID;
  final String voucherPref;
  final String link;
  final String vType;
  FetchVoucher({
    required this.voucherID,
    required this.voucherPref,
    required this.link,
    required this.vType,
  });
}

class FetchCustomerByPhone extends VoucherEvent {
  final String customerPhone;

  const FetchCustomerByPhone({
    required this.customerPhone,
  });

  @override
  List<Object> get props => [customerPhone];
}

class ExportToVoucher extends VoucherEvent {
  final String vType;
  ExportToVoucher({
    required this.vType,
  });
}

class FetchNextVoucherNumber extends VoucherEvent {
  final String voucherPref;

  FetchNextVoucherNumber({
    required this.voucherPref,
  });
}

class SetPrintCopy extends VoucherEvent {
  final bool printCopy;

  const SetPrintCopy({required this.printCopy});
}
