import '../../../Datamodels/HiveModels/address_book/contacts_data_model.dart';
import '../../../Datamodels/Masters/Accounts/LedgerMasterDataModel.dart';
import '../../../Datamodels/Masters/Inventory/CompoundItemDataModel.dart';
import '../../../Datamodels/Transactions/general_voucher_datamodel.dart';
import '../../../Login/constants.dart';
import '../../../Webservices/webservicePHP.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../Datamodels/Masters/Inventory/InventoryItemDataModel.dart';
import '../../../Utils/voucher_types.dart';

part 'voucher_event.dart';
part 'voucher_state.dart';

class VoucherBloc extends Bloc<VoucherEvent, VoucherState> {
  final Box settingsBox = Hive.box(HiveTagNames.Settings_Hive_Tag);
  VoucherBloc()
      : super(VoucherState(
          status: VoucherEditorStatus.initial,
        )) {
    on<SetVoucher>((event, emit) => emit(VoucherState(
          voucher: event.voucher,
          status: VoucherEditorStatus.loaded,
          vStatus: ViewStatus.create,
        )));
    on<SetTransactionType>((event, emit) => emit(VoucherState(
          voucher: state.voucher,
          type: event.transactionType,
          status: VoucherEditorStatus.loaded,
        )));
    on<SetEmptyVoucher>(((event, emit) async {
      await setEmptyVoucher(event.voucherType, emit);
    }));
    on<SetContact>((event, emit) {
      setContact(event, emit);
    });
    on<SwitchReference>(
      (event, emit) {
        print('Changed');
        emit(state.copyWith(
            voucher: state.voucher!.copyWith(reference: event.newReference)));
      },
    );
    on<SetMainLedger>((event, emit) => emit(state.copyWith(
          voucher: state.voucher?.copyWith(
            ledgerObject: event.ledger,
          ),
          status: VoucherEditorStatus.loaded,
        )));
    on<SetVoucherDate>((event, emit) => emit(state.copyWith(
            voucher: state.voucher?.copyWith(
          VoucherDate: event.voucherDate,
        ))));
    on<SetVoucherSalesman>((event, emit) => emit(state.copyWith(
            voucher: state.voucher?.copyWith(
          SalesmanID: event.salesmanID,
        ))));
    on<SetAddedByID>((event, emit) => emit(state.copyWith(
            voucher: state.voucher?.copyWith(
          AddedById: event.addedByID,
        ))));
    on<SetPriceList>((event, emit) => emit(state.copyWith(
            voucher: state.voucher?.copyWith(
          priceListId: event.priceListID,
        ))));
    on<SetNarration>((event, emit) => emit(state.copyWith(
            voucher: state.voucher?.copyWith(
          narration: event.narration,
        ))));
    on<VoucherRequestSave>((event, emit) => emit(state.copyWith(
          status: VoucherEditorStatus.requestSave,
        )));
    on<SaveVoucher>((event, emit) async => await saveVoucher(event, emit));
    on<AddInventoryItem>(
        (event, emit) => addInventoryItem(event.inventoryItem, emit));
    on<UpdateInventoryItemAtIndex>(
        (event, emit) => updateInventoryItem(event, emit));
    on<RemoveInventoryItemAtIndex>(
        (event, emit) => deleteInventoryItem(event, emit));
    on<UpdateItemQty>(
      (event, emit) => updateItemQty(emit, event.item, event.qty),
    );
    on<FetchVoucher>(
      (event, emit) async => await fetchVoucher(event, emit),
    );
    on<FetchCustomerByPhone>((event, emit) async {
      await fetchContactByPhone(event, emit);
    });

    on<RefreshVoucher>(
      (event, emit) {
        emit(state.copyWith(status: VoucherEditorStatus.loading));
        emit(state.copyWith(
            voucher: state.voucher!.copyWith(
              InventoryItems: [],
              ledgersList: [],
              ledgerObject: LedgerMasterDataModel(),
            ),
            status: VoucherEditorStatus.loaded));
      },
    );

    on<SetCustomerPhoneNumber>((event, emit) => emit(state.copyWith(
            voucher: state.voucher?.copyWith(
          POCPhone: event.phoneNumber,
        ))));
    on<SetCustomerName>((event, emit) => emit(state.copyWith(
            voucher: state.voucher?.copyWith(
          POCName: event.name,
        ))));

    on<SetCustomerAddress>(((event, emit) => emit(state.copyWith(
            voucher: state.voucher?.copyWith(
          Location: event.customerAddress,
        )))));
    on<FetchNextVoucherNumber>((event, emit) async {
      await fetchNextVoucherNumber(emit);
    });
    on<ExportToVoucher>((event, emit) {});
  }

  Future<void> setEmptyVoucher(voucherType, emit) async {
    final GeneralVoucherDataModel voucher = GeneralVoucherDataModel(
      voucherType: voucherType,
      VoucherDate: DateTime.now(),
      VoucherPrefix: settingsBox.get("vPref"),
      voucherNumber: '',
      SalesmanID: settingsBox.get('Salesman_ID'),
      AddedById: settingsBox.get('Salesman_ID'),
      ledgerObject: null,
      DeliveryDate: DateTime.now(),
      fromGodownID: settingsBox.get('defaultGodown'),
      status: 0,
      kotNumber: '',
      TransactionId: const Uuid().v4(),
      RequirementVoucherNo: const Uuid().v4(),
      ledgersList: [],
      InventoryItems: [],
      deletedItems: [],
    );
    emit(state.copyWith(
      voucher: voucher,
      status: VoucherEditorStatus.loaded,
      vStatus: ViewStatus.create,
    ));
    await fetchNextVoucherNumber(emit);
  }

  Future<void> fetchNextVoucherNumber(emit) async {
    final nextVoucherNumber = await WebservicePHPHelper.getNextVoucherNumber(
        state.voucher!.voucherType, state.voucher!.VoucherPrefix);
    if (nextVoucherNumber != null) {
      emit(state.copyWith(
        voucher: state.voucher?.copyWith(voucherNumber: nextVoucherNumber),
        status: VoucherEditorStatus.loaded,
        vStatus: ViewStatus.create,
      ));
    }
  }

  Future<void> fetchContactByPhone(event, emit) async {
    String number = event.customerPhone;
    ContactsDataModel? contact =
        await WebservicePHPHelper.getContactByNumber(number);
    print(contact);
    if (contact != null) {
      if (contact.PhoneNumber != null) {
        if (contact.PhoneNumber?.isEmpty == true) {
          contact = contact.copyWith(PhoneNumber: number);
        }
      } else {
        contact = contact.copyWith(PhoneNumber: number);
      }

      emit(state.copyWith(
          voucher: state.voucher?.copyWith(
        Contact: contact,
        POCName: contact.ContactName,
        Location: contact.address,
        POCPhone: contact.PhoneNumber,
      )));
    }
  }

  Future<void> saveVoucher(event, emit) async {
    print("Save Voucher");

    emit(state.copyWith(status: VoucherEditorStatus.sending));

    if (state.vStatus == ViewStatus.create ||
        state.vStatus == ViewStatus.exported) {
      emit(state.copyWith(
          voucher: state.voucher!.copyWith(
        voucherNumber: '',
        DateCreated: DateTime.now(),
      )));
    }
    final GeneralVoucherDataModel voucher =
        state.voucher!.copyWith(lastEditedDateTime: DateTime.now());
    voucher.calculateVoucherSales();

    final result = await WebservicePHPHelper.sendVoucher(
        vType: voucher.voucherType ?? "", voucher: voucher);

    print('Result : $result');

    if (result['Status'] == 'failed') {
      emit(state.copyWith(
        status: VoucherEditorStatus.senderror,
      ));
      return;
    }

    emit(state.copyWith(status: VoucherEditorStatus.sent));

    setEmptyVoucher(state.voucher!.voucherType, emit);

    //Save Data;
  }

  Future<void> fetchVoucher(event, emit) async {
    print("Fetch Voucher ${event.vType}");
    emit(state.copyWith(status: VoucherEditorStatus.loading));
    try {
      final GeneralVoucherDataModel? voucher =
          await WebservicePHPHelper.getVoucherByVoucherNo(
        voucherID: event.voucherID,
        voucherPrefix: event.voucherPref,
        link: event.link,
        voucherTpe: event.vType,
      );

      emit(state.copyWith(
        voucher: voucher,
        status: VoucherEditorStatus.loaded,
        vStatus: ViewStatus.edit,
      ));
    } catch (e) {
      print('Voucher fetch Error : ${e.toString()}');
      emit(state.copyWith(status: VoucherEditorStatus.fetcherror));
    }

    //Fetch Data;
  }

  void updateItemQty(emit, InventoryItemDataModel item, quantity) {
    var voucher = state.voucher!;
    if (voucher.getItemCount(item.ItemID!) == 0) {
      // if (quantity == 0) return;

      // item.prevQty = 0;

      voucher.InventoryItems!.add(CompoundItemDataModel(
          BaseItem: item.copyWith(
        quantity: quantity,
        currQty: quantity,
        crQty: quantity,
      )));
    } else {
      for (int i = 0; i < voucher.InventoryItems!.length; i++) {
        if (voucher.InventoryItems![i].BaseItem.ItemID == item.ItemID) {
          if (item.quantity == 0) {
            voucher.InventoryItems!.removeAt(i);
          } else {
            voucher.InventoryItems![i].BaseItem.copyWith(
                quantity: quantity, currQty: quantity, crQty: quantity);
          }
          break;
        }
      }
    }

    voucher.calculateVoucherSales();
    print('Calc Completed');
    emit(state.copyWith(voucher: voucher));
    print('Item count Increased');
    return;
  }

  void addInventoryItem(InventoryItemDataModel item, emit) {
    print("Add Inventory Item");
    emit(state.copyWith(status: VoucherEditorStatus.loading));
    final GeneralVoucherDataModel? voucher = state.voucher;
    voucher!.InventoryItems!.add(CompoundItemDataModel(BaseItem: item));
    voucher.calculateVoucherSales();
    emit(state.copyWith(voucher: voucher, status: VoucherEditorStatus.loaded));
  }

  void updateInventoryItem(event, emit) {
    print("Add Inventory Item");
    emit(state.copyWith(status: VoucherEditorStatus.loading));
    final GeneralVoucherDataModel? voucher = state.voucher;
    voucher!.InventoryItems![event.index] =
        CompoundItemDataModel(BaseItem: event.inventoryItem);
    voucher.calculateVoucherSales();
    emit(state.copyWith(voucher: voucher, status: VoucherEditorStatus.loaded));
  }

  void deleteInventoryItem(event, emit) {
    print("Add Inventory Item");
    emit(state.copyWith(status: VoucherEditorStatus.loading));
    final GeneralVoucherDataModel? voucher = state.voucher;
    voucher!.InventoryItems!.removeAt(event.index);
    voucher.calculateVoucherSales();
    emit(state.copyWith(voucher: voucher, status: VoucherEditorStatus.loaded));
  }

  void setContact(event, emit) {
    print("Add Address Book");
    emit(state.copyWith(status: VoucherEditorStatus.loading));
    emit(
      state.copyWith(
          status: VoucherEditorStatus.loaded,
          voucher: state.voucher!.copyWith(
            Contact: event.contact,
            POCPhone: event.contact.PhoneNumber,
            POCName: event.contact.ContactName,
            Location: event.contact.address ?? state.voucher?.Location,
          )),
    );
  }
}
