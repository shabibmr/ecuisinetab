// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'voucher_bloc.dart';

enum VoucherEditorStatus {
  initial,
  loading,
  loaded,
  fetcherror,
  requestSaveOrder,
  requestSaveInvoice,
  sending,
  sent,
  senderror,
  validationError,
}

enum ViewStatus {
  create,
  edit,
  revise,
  exported,
}

class VoucherState extends Equatable {
  const VoucherState({
    this.voucher,
    required this.status,
    this.msg,
    this.vStatus,
    this.type,
    this.printCopy,
    this.switchOption = false,
  });

  final GeneralVoucherDataModel? voucher;
  final VoucherEditorStatus status;
  final String? msg;
  final ViewStatus? vStatus;
  final TransactionType? type;
  final bool? printCopy;

  final bool? switchOption;

  @override
  List<Object?> get props => [
        voucher,
        status,
        msg,
        vStatus,
        type,
        printCopy,
        switchOption,
      ];

  VoucherState copyWith({
    GeneralVoucherDataModel? voucher,
    VoucherEditorStatus? status,
    String? msg,
    ViewStatus? vStatus,
    TransactionType? type,
    bool? printCopy,
    bool? switchOption,
  }) {
    return VoucherState(
      voucher: voucher ?? this.voucher,
      status: status ?? this.status,
      msg: msg ?? this.msg,
      vStatus: vStatus ?? this.vStatus,
      type: type ?? this.type,
      printCopy: printCopy ?? this.printCopy,
      switchOption: switchOption ?? this.switchOption,
    );
  }
}
