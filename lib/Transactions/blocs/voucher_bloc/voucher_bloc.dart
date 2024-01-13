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
        print(state.voucher?.reference ?? 'Still NULl');
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
      reference: '',
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
    emit(state.copyWith(status: VoucherEditorStatus.loading));
    final voucher = state.voucher!;
    voucher.InventoryItems?.forEach((element) {
      print('${element.BaseItem.ItemName} - ${element.BaseItem.quantity} ');
    });
    print('qq : ${voucher.getItemCurrCount(item.ItemID!)}');
    if (voucher.getItemCurrCount(item.ItemID!) == 0) {
      // if (quantity == 0) return;

      // item.prevQty = 0;
      print('Adding Item quan : $quantity');

      voucher.InventoryItems!.add(CompoundItemDataModel(
          BaseItem: item.copyWith(
        quantity: quantity,
        currQty: quantity,
        crQty: quantity,
      )));
    } else {
      int i = 0;
      for (; i < voucher.InventoryItems!.length; i++) {
        print(
            '$i ::: ${voucher.InventoryItems![i].BaseItem.ItemName} : ${voucher.InventoryItems![i].BaseItem.quantity}');
        if (voucher.InventoryItems![i].BaseItem.ItemID == item.ItemID &&
            (voucher.InventoryItems![i].BaseItem.prevQty ?? 0) == 0) {
          print(' New quanttity updated to $quantity');
          voucher.InventoryItems?[i] = CompoundItemDataModel(
              BaseItem: voucher.InventoryItems![i].BaseItem.copyWith(
                  quantity: quantity, currQty: quantity, crQty: quantity));

          if (voucher.InventoryItems![i].BaseItem.quantity == 0) {
            print('Item Removed at index : $i');
            voucher.InventoryItems!.removeAt(i);
          }
          break;
        }
      }
      print(' updated at index : $i');
    }
    print('Item Updated Done');
    voucher.calculateVoucherSales();
    print('Calc Completed');
    emit(state.copyWith(
      voucher: voucher,
      status: VoucherEditorStatus.loaded,
    ));
    print('Item count Increased');
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
