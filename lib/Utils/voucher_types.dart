class GMVoucherTypes {
  static String get SalesVoucher => "SalesVoucher";
  static String get SalesOrder => "SalesOrder";
  static String get PurchaseVoucher => "PurchaseVoucher";
  static String get PurchaseOrder => "PurchaseOrder";
  static String get CreditNote => "CreditNote";
  static String get DebitNote => "DebitNote";
  static String get ReceiptNote => "ReceiptNote";
  static String get DeliveryNote => "DeliveryNote";

  static String get WorkOrder => "Work Order";

  static String get ReceiptVoucher => "ReceiptVoucher";
  static String get PaymentVoucher => "PaymentVoucher";
  static String get JournalVoucher => "JournalVoucher";

  static String get Quotation => "Quotation";
  static String get Proforma => "Proforma";

  static String get GodownTransfer => "GodownTransfer";
  static String get StockEntry => "Stock";
  static String get StockJournal => "StockJournal";
  static String get WastageEntry => "WastageEntry";
  static String get StockRequest => "Stock Request";
  static String get ContraVoucher => "ContraVoucher";

  static String get Opening => "Opening";

  static TransactionType getTransactionType(String voucherType) {
    switch (voucherType) {
      case 'SalesVoucher':
      case 'SalesOrder':
      case 'DeliveryNote':
      case 'WorkOrder':
      case 'Quotation':
      case 'Proforma':
      case 'DebitNote':
      case 'PaymentVoucher':
        return TransactionType.outward;
      case 'PurchaseVoucher':
      case 'PurchaseOrder':
      case 'ReceiptNote':
      case 'CreditNote':
      case 'ReceiptVoucher':
        return TransactionType.inward;

      case 'JournalVoucher':
      case 'GodownTransfer':
      case 'StockEntry':
      case 'StockJournal':
      case 'WastageEntry':
      case 'StockRequest':
      case 'ContraVoucher':
      case 'Opening':
        return TransactionType.transfer;
      default:
        return TransactionType.transfer;
    }
  }
}

enum TransactionType {
  inward,
  outward,
  transfer,
}
