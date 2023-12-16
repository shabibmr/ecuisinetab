import '../../../Datamodels/HiveModels/UOM/UOMHiveModel.dart';
import '../../../Datamodels/Masters/Inventory/InventoryItemDataModel.dart';
import '../../../Datamodels/Masters/Inventory/item_batch_datamodel.dart';
import '../../../Webservices/webservicePHP.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../../../../../Utils/voucher_types.dart';

part 'inventory_item_detail_event.dart';
part 'inventory_item_detail_state.dart';

class InventoryItemDetailBloc
    extends Bloc<InventoryItemDetailEvent, InventoryItemDetailState> {
  InventoryItemDetailBloc({InventoryItemDataModel? item})
      : super(const InventoryItemDetailState(
          status: ItemDetailStatus.init,
        )) {
    // print(' item Price : ${item!.rate} - Uom : ${item.uomObject!.uom_Name}');
    on<SetItem>((event, emit) {
      setItem(event.item, emit);
    });
    on<SetItemTransactionType>(
        (event, emit) => emit(state.copyWith(type: event.type)));
    on<SetItemQuantity>(((event, emit) => setQuantity(event.qty, emit)));
    on<SetItemRate>(((event, emit) => setRate(event.rate, emit)));
    on<SetItemDiscountPercent>(((event, emit) {
      double percent = event.discPercent;
      double amount = (state.item!.subTotal ?? 0) * percent / 100;
      final item = state.item?.copyWith(
        discountPercentage: event.discPercent,
        discountinAmount: amount,
      );
      item?.calculate();
      print('Qty chng pr : ${item?.rate}  - ${item?.taxRate}');
      emit(state.copyWith(
        item: item,
      ));
    }));
    on<SetItemDiscountAmount>(((event, emit) {
      double amount = event.discAmount;
      double percent = (amount / (state.item!.subTotal ?? 0)) * 100;
      final item = state.item?.copyWith(
        discountPercentage: percent,
        discountinAmount: amount,
      );
      item?.calculate();
      print('Qty chng am : ${item?.rate}  - ${item?.taxRate}');
      emit(state.copyWith(
        item: item,
      ));
    }));
    on<SetFromGodown>(((event, emit) {
      emit(state.copyWith(
          item: state.item!.copyWith(fromGodownID: event.godownID)));
    }));
    on<SetToGodown>(((event, emit) {
      emit(state.copyWith(
          item: state.item!.copyWith(toGodownID: event.godownID)));
    }));
    on<ItemDetailShowBatchEditor>(((event, emit) {
      emit(state.copyWith(showBatchEditor: event.show));
    }));

    on<SetItemUOM>(((event, emit) {
      final item = state.item!.copyWith(
        uomObject: event.uom,
        quantity: (state.item?.quantity ?? 0) * (event.uom.convRate ?? 1),
      );
      item.calculate();
      emit(state.copyWith(item: item));
    }));

    on<ItemUpdateBatch>((event, emit) {
      print('batch : ${event.batch}');
      print('index : ${event.index}');
      if (state.item!.batchList == null || state.item!.batchList!.length == 0) {
        emit(state.copyWith(
            item: state.item!.copyWith(batchList: List.from([event.batch]))));
      } else {
        final batchlist = state.item!.batchList!..add(event.batch);
        emit(state.copyWith(
            item: state.item!.copyWith(batchList: List.from(batchlist))));
      }
      if (event.index > state.item!.batchList!.length) {}
    });

    on<GetClosingStock>((event, emit) async {
      try {
        final List data = await WebservicePHPHelper.getReportList(
          link: 'inventory_webservice.php?action=getGdownwiseItemStock',
          dateFrom: DateTime.now(),
          dateTo: event.toDate,
          map: {'itemID': state.item?.ItemID},
        );
        double stock = 0;
        data.forEach((element) {
          stock = stock + double.parse(element['stock'] ?? '0');
        });
        emit(state.copyWith(
          item: state.item!.copyWith(ClosingStock: stock),
        ));
      } catch (e) {
        print(e);
      }
    });

    on<ItemDetailFetchItemBatches>(
      (event, emit) async {
        await fetchAvailableBatches(
            state.item!.ItemID!, event.date, event.vNo, event.vPref, emit);
      },
    );
  }

  void setItem(item, emit) {
    print('Tax : ${item.taxRate}');
    emit(state.copyWith(
      item: item,
      status: ItemDetailStatus.ready,
    ));

    // getItemStockDetail
  }

  void setQuantity(qty, emit) {
    if (qty < 0) return;

    print('BLCO Qty : ${state.item!.quantity}');

    emit(state.copyWith(
        item: state.item
            ?.copyWith(quantity: qty * state.item!.uomObject!.convRate!)));
    calculate(emit);
  }

  void setRate(rate, emit) {
    print('>Set Rate');
    if (rate < 0) return;

    final item = state.item?.copyWith(
      rate: rate,
    );

    calculate(emit);
  }

  void calculate(emit) {
    final item = state.item;
    double subTotal = item!.quantity! * item.rate!;
    double discAmount = subTotal * item.discountPercentage!;
    double gross = subTotal - discAmount;
    double taxAmt = gross * item.taxRate! / 100;
    double total = gross + taxAmt;

    emit(state.copyWith(
        item: item.copyWith(
      subTotal: subTotal,
      discountinAmount: discAmount,
      grossTotal: gross,
      grandTotal: total,
      taxAmount: taxAmt,
    )));
  }

  Future<void> fetchAvailableBatches(
      String itemID, DateTime date, String vNo, String vPref, emit) async {
    // 1. Fetch Available Batches
    // 2. Calculate Qty

    emit(state.copyWith(batchFetchStatus: FetchStatus.reading));
    try {
      Map map = {
        'item_id': itemID,
        'date': DateFormat('yyyy-MM-dd').format(date),
        'voucher_no': vNo,
        'voucher_pref': vPref,
        'voucher_type': state.type,
      };
      final List? data = await WebservicePHPHelper.getQueryResult(
        link: 'action=get_item_batches_available',
        map: map,
      );

      if (data == false) {
        emit(state.copyWith(batchFetchStatus: FetchStatus.error));
      } else {
        //fetch bathces
        final List<BatchDataModel> batches = data!
            .map<BatchDataModel>((e) => BatchDataModel.fromMap(e))
            .toList();

        // 2. Calculate Qty
        emit(state.copyWith(
          batchFetchStatus: FetchStatus.ready,
          item: state.item!.copyWith(batchList: batches),
        ));
      }
    } catch (e) {
      emit(state.copyWith(batchFetchStatus: FetchStatus.error));
    }
  }
}
