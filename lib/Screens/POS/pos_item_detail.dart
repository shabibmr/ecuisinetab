import 'package:ecuisinetab/Datamodels/Masters/Inventory/InventoryItemDataModel.dart';
import 'package:ecuisinetab/Transactions/blocs/voucher_bloc/voucher_bloc.dart';
import 'package:ecuisinetab/widgets/Basic/MNumText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Transactions/InventoryItem/bloc/inventory_item_detail_bloc.dart';

class POSItemDetailPage extends StatefulWidget {
  POSItemDetailPage({Key? key}) : super(key: key);

  @override
  State<POSItemDetailPage> createState() => _POSItemDetailPageState();
}

class _POSItemDetailPageState extends State<POSItemDetailPage> {
  @override
  Widget build(BuildContext context) {
    return getBody();
  }

  Widget getBody() {
    return Builder(builder: (context) {
      // status: ItemDetailStatus.ready,
      final status =
          context.select((InventoryItemDetailBloc bloc) => bloc.state.status);
      if (status == ItemDetailStatus.ready) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.blue.shade50,
                  ),
                ),
                Container(
                  height: 3,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.yellow.shade50,
                    child: Column(
                      children: [
                        Text('Item Name'),
                        ItemQuantity(),
                        Text('Item Price'),
                        Text('Item Total'),
                        Text('Item Narration'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: Builder(builder: (context) {
            final InventoryItemDataModel item = context
                .select((InventoryItemDetailBloc blox) => blox.state.item!);
            return FloatingActionButton(
              onPressed: () {
                print('Pressed');
                Navigator.of(context).pop(item);
              },
              child: const Icon(Icons.check),
            );
          }),
        );
      } else {
        return Text('${status}');
      }
    });
  }
}

class ItemQuantity extends StatefulWidget {
  const ItemQuantity({Key? key}) : super(key: key);

  @override
  State<ItemQuantity> createState() => _ItemQuantityState();
}

class _ItemQuantityState extends State<ItemQuantity> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      double? qty = context.select((InventoryItemDetailBloc element) =>
          element.state.item?.quantity ?? 0);
      int dec = context.select((InventoryItemDetailBloc element) =>
          element.state.item?.uomObject?.UOM_decimal_Points ?? 0);
      print('New Qty Build :$qty');
      return Card(
        child: MNumField(
          label: 'Quantity',
          showBorder: true,
          showSuffix: false,
          // focusNode: FocusNode(),
          autoFocus: true,
          selectAllOnClick: true,
          textAlign: TextAlign.right,
          textData: qty?.toStringAsFixed(dec) ?? '0',
          textStyle: Theme.of(context).textTheme.titleLarge,
          readOnly: false,
          onChanged: (value) {
            context
                .read<InventoryItemDetailBloc>()
                .add(SetItemQuantity(value.toDouble()));
          },
        ),
      );
    });
  }
}
