import '../../../Datamodels/HiveModels/InventoryItems/InvetoryItemDataModel.dart';
import '../../../Login/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'pos_event.dart';
part 'pos_state.dart';

class PosBloc extends Bloc<PosEvent, PosState> {
  Box<InventoryItemHive> itemsBox = Hive.box(HiveTagNames.Items_Hive_Tag);
  PosBloc()
      : super(PosState(
          status: POSStatus.NEW,
        )) {
    on<GroupSelected>((event, emit) {
      emit(state.copyWith(
        itemsLoadStaus: ItemsLoadingStatus.ItemsLoading,
      ));
      final List<InventoryItemHive>? items = itemsBox.values.where((element) {
        // print('${element.Group_Id} to ${event.groupID}');
        return element.Group_Id == event.groupID;
      }).toList();

      // print(
      //     'Items Filtered : ${items?.length} before : ${state.items?.length}');

      emit(state.copyWith(
        itemsLoadStaus: ItemsLoadingStatus.ItemsLoaded,
        items: items,
      ));
    });
  }
}
