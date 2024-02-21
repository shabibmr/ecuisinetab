// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'voucher_bloc.dart';

abstract class VoucherEvent extends Equatable {
  const VoucherEvent();

  @override
  List<Object?> get props => [];
}

class SetMainLedger extends VoucherEvent {
  final LedgerMasterDataModel? ledger;

  const SetMainLedger({
    required this.ledger,
  });

  @override
  List<Object?> get props => [ledger];
}

class SetVoucherDate extends VoucherEvent {
  final DateTime voucherDate;

  const SetVoucherDate({
    required this.voucherDate,
  });

  @override
  List<Object> get props => [voucherDate];
}

class SetInvoiceDate extends VoucherEvent {
  final DateTime invoiceDate;

  const SetInvoiceDate({
    required this.invoiceDate,
  });

  @override
  List<Object> get props => [invoiceDate];
}

class SetInvoiceNumber extends VoucherEvent {
  final String invoiceNo;

  const SetInvoiceNumber({
    required this.invoiceNo,
  });

  @override
  List<Object> get props => [invoiceNo];
}

class SetVoucherSalesman extends VoucherEvent {
  final int salesmanID;

  const SetVoucherSalesman({
    required this.salesmanID,
  });

  @override
  List<Object> get props => [salesmanID];
}

class SetAddedByID extends VoucherEvent {
  final int addedByID;

  const SetAddedByID({
    required this.addedByID,
  });

  @override
  List<Object> get props => [addedByID];
}

class SetPriceList extends VoucherEvent {
  final int priceListID;

  const SetPriceList({
    required this.priceListID,
  });

  @override
  List<Object> get props => [priceListID];
}

class SetNarration extends VoucherEvent {
  final String narration;

  const SetNarration({
    required this.narration,
  });

  @override
  List<Object> get props => [narration];
}

class SaveVoucherOrder extends VoucherEvent {
  const SaveVoucherOrder();

  @override
  List<Object> get props => [];
}

class RejectSaveVoucherOrder extends VoucherEvent {
  const RejectSaveVoucherOrder();

  @override
  List<Object> get props => [];
}

class SaveVoucherInvoice extends VoucherEvent {
  const SaveVoucherInvoice();

  @override
  List<Object> get props => [];
}

class RejectSaveVoucherInvoice extends VoucherEvent {
  const RejectSaveVoucherInvoice();

  @override
  List<Object> get props => [];
}

class VoucherRequestSaveOrder extends VoucherEvent {
  const VoucherRequestSaveOrder();

  @override
  List<Object> get props => [];
}

class VoucherRequestSaveInvoice extends VoucherEvent {
  const VoucherRequestSaveInvoice();

  @override
  List<Object> get props => [];
}

class SetVoucherID extends VoucherEvent {
  final String voucherID;

  const SetVoucherID({
    required this.voucherID,
  });

  @override
  List<Object> get props => [voucherID];
}

class SetVoucher extends VoucherEvent {
  final GeneralVoucherDataModel voucher;

  const SetVoucher({
    required this.voucher,
  });

  @override
  List<Object> get props => [voucher];
}

class RefreshVoucher extends VoucherEvent {
  const RefreshVoucher();

  @override
  List<Object> get props => [];
}

class SetTransactionType extends VoucherEvent {
  final TransactionType transactionType;

  const SetTransactionType({
    required this.transactionType,
  });
}

class SetDiscountPercentage extends VoucherEvent {
  final double discountPercentage;

  const SetDiscountPercentage({
    required this.discountPercentage,
  });

  @override
  List<Object> get props => [discountPercentage];
}

class SetDiscountAmount extends VoucherEvent {
  final double discountAmount;

  const SetDiscountAmount({
    required this.discountAmount,
  });

  @override
  List<Object> get props => [discountAmount];
}

class SetEmptyVoucher extends VoucherEvent {
  final String voucherType;

  const SetEmptyVoucher({
    required this.voucherType,
  });

  @override
  List<Object> get props => [voucherType];
}

class SetVoucherType extends VoucherEvent {
  final String voucherType;

  const SetVoucherType({
    required this.voucherType,
  });
}

class SetToGodownID extends VoucherEvent {
  final String toGodownID;

  const SetToGodownID({
    required this.toGodownID,
  });

  @override
  List<Object> get props => [toGodownID];
}

class SetFromGodownID extends VoucherEvent {
  final String fromGodownID;

  const SetFromGodownID({
    required this.fromGodownID,
  });

  @override
  List<Object> get props => [fromGodownID];
}

class SetCustomerAddress extends VoucherEvent {
  final String customerAddress;

  const SetCustomerAddress({
    required this.customerAddress,
  });

  @override
  List<Object> get props => [customerAddress];
}

class SetCustomerPhoneNumber extends VoucherEvent {
  final String phoneNumber;

  const SetCustomerPhoneNumber({
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [phoneNumber];
}

class SetCustomerName extends VoucherEvent {
  final String name;

  const SetCustomerName({
    required this.name,
  });

  @override
  List<Object> get props => [name];
}

class SwitchReference extends VoucherEvent {
  final String newReference;

  const SwitchReference({
    required this.newReference,
  });

  @override
  List<Object> get props => [newReference];
}

class RecalculateVoucher extends VoucherEvent {
  const RecalculateVoucher();

  @override
  List<Object> get props => [];
}

class AddInventoryItem extends VoucherEvent {
  final InventoryItemDataModel inventoryItem;

  const AddInventoryItem({
    required this.inventoryItem,
  });

  @override
  List<Object> get props => [inventoryItem];
}

class UpdateInventoryItemAtIndex extends VoucherEvent {
  final int index;
  final InventoryItemDataModel inventoryItem;

  const UpdateInventoryItemAtIndex({
    required this.index,
    required this.inventoryItem,
  });

  @override
  List<Object> get props => [index, inventoryItem];
}

class RemoveInventoryItemAtIndex extends VoucherEvent {
  final int index;

  const RemoveInventoryItemAtIndex({
    required this.index,
  });

  @override
  List<Object> get props => [index];
}

class AddLedger extends VoucherEvent {
  final LedgerMasterDataModel ledger;

  const AddLedger({
    required this.ledger,
  });

  @override
  List<Object> get props => [ledger];
}

class UpdateLedgerAtIndex extends VoucherEvent {
  final int index;
  final LedgerMasterDataModel ledger;

  const UpdateLedgerAtIndex({
    required this.index,
    required this.ledger,
  });

  @override
  List<Object> get props => [index, ledger];
}

class DeleteLedgerAtIndex extends VoucherEvent {
  final int index;

  const DeleteLedgerAtIndex({
    required this.index,
  });

  @override
  List<Object> get props => [index];
}

class SetContact extends VoucherEvent {
  final ContactsDataModel contact;

  const SetContact({
    required this.contact,
  });

  @override
  List<Object> get props => [contact];
}

class UpdateItemQty extends VoucherEvent {
  final num qty;
  final InventoryItemDataModel item;

  const UpdateItemQty({
    required this.item,
    required this.qty,
  });
}

class FetchVoucher extends VoucherEvent {
  final String voucherID;
  final String voucherPref;
  final String link;
  final String vType;
  const FetchVoucher({
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
  const ExportToVoucher({
    required this.vType,
  });
}

class FetchNextVoucherNumber extends VoucherEvent {
  final String voucherPref;

  const FetchNextVoucherNumber({
    required this.voucherPref,
  });
}

class SetPrintCopy extends VoucherEvent {
  final bool printCopy;

  const SetPrintCopy({required this.printCopy});
}
