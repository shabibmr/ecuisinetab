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
        return element.Group_Id == event.groupID;
      }).toList();

      // print(
      //     'Items Filtered : ${items?.length} before : ${state.items?.length}');

      emit(state.copyWith(
        itemsLoadStaus: SyncStatus.ItemsLoaded,
        items: items,
      ));
    });
    on<OrderSelected>((event, emit) {
      emit(state.copyWith(
        status: POSStatus.OrderSelected,
      ));
    });
  }

  Future<void> getCurrentOrders() async {
    try {
      print('Getting Orders');
      final data = WebservicePHPHelper.getCurrentOrders();
      if (data == false) {
        emit(state.copyWith(status: POSStatus.OrderFetchError));
      }
    } catch (e) {
      print('error in getCurrentOrders : ${e.toString()}');
    }
  }
}
