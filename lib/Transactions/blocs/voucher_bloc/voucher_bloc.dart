import 'package:ecuisinetab/Datamodels/HiveModels/InventoryItems/InvetoryItemDataModel.dart';
import 'package:ecuisinetab/Datamodels/HiveModels/PriceList/PriceListEntriesHive.dart';

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
      : super(const VoucherState(
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
    on<RecalculateVoucher>(
      (event, emit) {
        final voucher = state.voucher;
        voucher!.calculateVoucherSales();
        emit(state.copyWith(voucher: voucher));
      },
    );
    on<SwitchReference>(
      (event, emit) {
        print('Changed voucher reference ${event.newReference}');
        emit(VoucherState(
          voucher: state.voucher?.copyWith(reference: event.newReference),
          status: VoucherEditorStatus.loaded,
        ));
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
    on<SetPriceList>((event, emit) {
      resetPrices(event, emit);
    });
    on<SetNarration>((event, emit) => emit(state.copyWith(
            voucher: state.voucher?.copyWith(
          narration: event.narration,
        ))));
    on<VoucherRequestSaveOrder>((event, emit) => emit(state.copyWith(
          status: VoucherEditorStatus.requestSaveOrder,
        )));
    on<VoucherRequestSaveInvoice>((event, emit) => emit(state.copyWith(
          status: VoucherEditorStatus.requestSaveInvoice,
        )));
    on<SaveVoucherOrder>(
        (event, emit) async => await saveVoucherOrder(event, emit));
    on<SaveVoucherInvoice>(
        (event, emit) async => await saveVoucherInvoice(event, emit));
    on<AddInventoryItem>(
        (event, emit) => addInventoryItem(event.inventoryItem, emit));
    on<UpdateInventoryItemAtIndex>(
        (event, emit) => updateInventoryItem(event, emit));
    on<RemoveInventoryItemAtIndex>(
        (event, emit) => deleteInventoryItem(event, emit));
    on<UpdateItemQty>(
      (event, emit) => updateItemQty(emit, event.item, event.qty),
    );
    on<SetVoucherType>(
      (event, emit) => emit(state.copyWith(
          voucher: state.voucher?.copyWith(voucherType: event.voucherType))),
    );

    on<SetPrintCopy>(
      (event, emit) => emit(state.copyWith(printCopy: event.printCopy)),
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
    print('SETTING EMPTY VOUCHER');
    final GeneralVoucherDataModel voucher = GeneralVoucherDataModel(
      voucherType: voucherType,
      VoucherDate: DateTime.now(),
      DateCreated: DateTime.now(),
      VoucherPrefix: settingsBox.get(Config_Tag_Names.Voucher_Prefix_Tag),
      voucherNumber: '',
      SalesmanID: settingsBox.get(Config_Tag_Names.Salesmain_ID_Tag),
      AddedById: settingsBox.get(Config_Tag_Names.Salesmain_ID_Tag),
      ledgerObject: LedgerMasterDataModel(
        LedgerID: '0x5x2x1',
      ),
      DeliveryDate: DateTime.now(),
      fromGodownID: settingsBox.get(Config_Tag_Names.Default_Godown_ID),
      status: 110,
      kotNumber: '',
      TransactionId: const Uuid().v4(),
      RequirementVoucherNo: const Uuid().v4(),
      ledgersList: [],
      InventoryItems: [],
      deletedItems: [],
      reference: '',
    );
    emit(state.copyWith(
      voucher: voucher,
      status: VoucherEditorStatus.loaded,
      vStatus: ViewStatus.create,
      printCopy: false,
    ));
    await fetchNextVoucherNumber(emit);
  }

  Future<void> fetchNextVoucherNumber(emit) async {
    try {
      final nextVoucherNumber = await WebservicePHPHelper.getNextVoucherNumber(
          state.voucher!.voucherType, state.voucher!.VoucherPrefix);
      if (nextVoucherNumber != null) {
        emit(state.copyWith(
          voucher: state.voucher?.copyWith(voucherNumber: nextVoucherNumber),
          status: VoucherEditorStatus.loaded,
          vStatus: ViewStatus.create,
        ));
      }
    } on Exception catch (ex) {
      print('Exception Fetching next Voucher nUmber : ${ex.toString()}');
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

  Future<void> saveVoucherOrder(event, emit) async {
    print("Save Voucher");

    emit(state.copyWith(status: VoucherEditorStatus.sending));

    int? status;

    status = state.voucher!.priceListId == 1 ? 130 : 110;

    if (state.vStatus == ViewStatus.create ||
        state.vStatus == ViewStatus.exported) {
      emit(state.copyWith(
          voucher: state.voucher!.copyWith(
        voucherNumber: '',
        DateCreated: DateTime.now(),
        status: 110,
      )));
    }
    final GeneralVoucherDataModel voucher =
        state.voucher!.copyWith(lastEditedDateTime: DateTime.now());
    voucher.calculateVoucherSales();

    try {
      final result = await WebservicePHPHelper.sendVoucher(
          vType: voucher.voucherType ?? "",
          voucher: voucher,
          requestBillCopy: state.printCopy);

      print('Result : $result');

      if (result['Status'] == 'failed') {
        emit(state.copyWith(
          status: VoucherEditorStatus.senderror,
        ));
        return;
      }
    } catch (ex) {
      print('Exception : $ex');
      emit(state.copyWith(
        status: VoucherEditorStatus.senderror,
      ));
      return;
    }

    emit(state.copyWith(status: VoucherEditorStatus.sent));

    await setEmptyVoucher(state.voucher!.voucherType, emit);

    //Save Data;
  }

  Future<void> saveVoucherInvoice(event, emit) async {
    print("Save Voucher Invoice ");

    emit(state.copyWith(status: VoucherEditorStatus.sending));
    if (state.voucher!.ledgerObject!.LedgerID?.isEmpty == true) {
      emit(state.copyWith(
          status: VoucherEditorStatus.validationError,
          msg: 'Please Select Customer'));
      return;
    }
    if (state.voucher!.ledgersList.isEmpty) {}

    emit(state.copyWith(
        voucher: state.voucher!.copyWith(
      narration: '',
      ConvertedToSalesOrder: state.voucher!.voucherNumber,
      voucherType: GMVoucherTypes.SalesVoucher,
      voucherNumber: '',
      ledgerObject: LedgerMasterDataModel(
        LedgerID: '0x5x21x2',
      ),
      VoucherDate: DateTime.now(),
      DateCreated: DateTime.now(),
      timestamp: DateTime.now(),
      status: 170,
      TransactionId: const Uuid().v4(),
    )));

    print('New Voucher Type : ${state.voucher!.voucherType} ');
    final GeneralVoucherDataModel voucher =
        state.voucher!.copyWith(lastEditedDateTime: DateTime.now());

    voucher.calculateVoucherSales();
    print('New Voucher Status : ${state.voucher!.status} ');
    try {
      final result = await WebservicePHPHelper.sendVoucher(
          vType: voucher.voucherType ?? "",
          voucher: voucher,
          requestBillCopy: state.printCopy);

      print('Result : $result');

      if (result['Status'] == 'failed') {
        emit(state.copyWith(
          status: VoucherEditorStatus.senderror,
        ));
        return;
      }
    } catch (ex) {
      print(ex.toString());
      emit(state.copyWith(
        status: VoucherEditorStatus.senderror,
      ));
      return;
    }

    emit(state.copyWith(status: VoucherEditorStatus.sent));

    await setEmptyVoucher(GMVoucherTypes.SalesOrder, emit);

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
    emit(state.copyWith(status: VoucherEditorStatus.loading));
    final voucher = state.voucher!;
    print('Updating Item Qty  : $quantity ');
    if (voucher.getItemCurrCount(item.ItemID!) == 0) {
      print('New Item FOUND');
      voucher.InventoryItems!.add(CompoundItemDataModel(
          BaseItem: item.copyWith(
        quantity: quantity,
        currQty: quantity,
        crQty: quantity,
      )));
    } else {
      int i = 0;
      for (; i < voucher.InventoryItems!.length; i++) {
        if (voucher.InventoryItems![i].BaseItem.ItemID == item.ItemID &&
            (voucher.InventoryItems![i].BaseItem.prevQty ?? 0) == 0) {
          voucher.InventoryItems?[i] = CompoundItemDataModel(
              BaseItem: voucher.InventoryItems![i].BaseItem.copyWith(
                  quantity: quantity, currQty: quantity, crQty: quantity));

          if (voucher.InventoryItems![i].BaseItem.quantity == 0) {
            voucher.InventoryItems!.removeAt(i);
          }
          break;
        }
      }
    }
    voucher.calculateVoucherSales();
    emit(state.copyWith(
      voucher: voucher,
      status: VoucherEditorStatus.loaded,
    ));
    return;
  }

  void addInventoryItem(InventoryItemDataModel item, emit) {
    print("Add Inventory Item");
    emit(state.copyWith(status: VoucherEditorStatus.loading));
    final GeneralVoucherDataModel? voucher = state.voucher?.copyWith(
        InventoryItems: state.voucher?.InventoryItems
          ?..add(CompoundItemDataModel(BaseItem: item)));

    // voucher!.InventoryItems!.add(CompoundItemDataModel(BaseItem: item));
    voucher!.calculateVoucherSales();
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
    print("Delete Inventory Item");
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

  void resetPrices(SetPriceList event, emit) {
    Box<InventoryItemHive> itemsBox = Hive.box(HiveTagNames.Items_Hive_Tag);
    Box<PriceListEntriesHive> pbox =
        Hive.box(HiveTagNames.PriceListsEntries_Hive_Tag);
    print('prices count  :: ${pbox.length}');
    final voucher = state.voucher!.copyWith(
        priceListId: event.priceListID, ModeOfService: event.priceListID);

    for (int i = 0; i < voucher.InventoryItems!.length; i++) {
      print(itemsBox.get(voucher.InventoryItems![i].BaseItem.ItemID)?.prices);
      final double? pRate = itemsBox
          .get(voucher.InventoryItems![i].BaseItem.ItemID)
          ?.prices?[voucher.priceListId]
          ?.rate;

      if (pRate != null) {
        voucher.InventoryItems![i] = voucher.InventoryItems![i].copyWith(
            BaseItem:
                voucher.InventoryItems?[i].BaseItem.copyWith(rate: pRate));
      }
    }
    voucher.calculateVoucherSales();
    emit(state.copyWith(voucher: voucher));
  }
}
