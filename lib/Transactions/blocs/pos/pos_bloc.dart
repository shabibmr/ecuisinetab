import 'package:ecuisinetab/Webservices/webservicePHP.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Datamodels/HiveModels/InventoryItems/InvetoryItemDataModel.dart';
import '../../../Login/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'pos_event.dart';
part 'pos_state.dart';

class PosBloc extends Bloc<PosEvent, PosState> {
  Box<InventoryItemHive> itemsBox = Hive.box(HiveTagNames.Items_Hive_Tag);
  PosBloc()
      : super(const PosState(
          status: POSStatus.NEW,
        )) {
    on<GroupSelected>((event, emit) {
      emit(state.copyWith(
        itemsLoadStaus: SyncStatus.ItemsLoading,
      ));
      final List<InventoryItemHive> items = itemsBox.values.where((element) {
        // print('${element.Group_Id} to ${event.groupID}');
        return element.Group_Id == event.groupID &&
            (element.isSalesItem == true);
      }).toList();

      print('Items Filtered : ${items.length} before : ${state.items?.length}');

      emit(state.copyWith(
        itemsLoadStaus: SyncStatus.ItemsLoaded,
        items: items,
        currentGroupID: event.groupID,
      ));
      print('Emit Completed');
    });
    on<OrderSelected>((event, emit) {
      emit(state.copyWith(
        status: POSStatus.OrderSelected,
        vID: event.voucherNo,
        vPrefix: event.vPrefix,
      ));
    });
    on<OrderSent>((event, emit) async {
      emit(state.copyWith(
        currentOrders: {},
        status: POSStatus.NEW,
      ));
      await getCurrentOrders(event, emit);
    });
    on<FetchCurrentOrders>((event, emit) async {
      await getCurrentOrders(event, emit);
    });
    on<RefreshPOS>((event, emit) {
      emit(state.copyWith(
        status: POSStatus.NEW,
        currentOrders: {},
      ));
    });
    on<UpdateItem>(((event, emit) {
      final Map<String, double> newMap = Map.from(state.currentKOT ?? {})
        ..[event.itemID] = event.quantity;

      emit(state.copyWith(currentKOT: newMap));
    }));
  }

  Future<void> getCurrentOrders(event, emit) async {
    try {
      print('Getting Orders');
      emit(state.copyWith(status: POSStatus.FetchingOrders));
      final data = await WebservicePHPHelper.getCurrentOrders();
      if (data == false) {
        emit(state.copyWith(status: POSStatus.OrderFetchError));
      } else {
        // final List tables =
        //     data['data_tables'][0]['data_tables'].toString().split('|');
        List<String> tables =
            data['data_tables'][0]['Tables'].toString().split('|');
        // print('Tables : $tables');
        Map<String, dynamic> ordersMap = {};
        if (data['success'].toString() == "1") {
          // print('Type : ${data['data'].runtimeType}');
          final List orders = data['data'];
          orders.forEach((element) {
            String ref = element['reference'] ?? '';
            // print('Ref : ${element['reference']}');
            if (!tables.contains(ref)) {
              tables.add(ref);
            }
            ordersMap[ref] = element;
          });

          emit(state.copyWith(
            tables: tables,
            currentOrders: ordersMap,
            status: POSStatus.OrdersFetched,
          ));
        } else {
          emit(state.copyWith(
            tables: tables,
            currentOrders: {},
            status: POSStatus.OrdersFetched,
          ));
        }
      }
    } catch (e) {
      print('error in getCurrentOrders : ${e.toString()}');
    }
  }
}
