import 'package:ecuisinetab/Screens/POS/voucher_editor.dart';
import 'package:ecuisinetab/Transactions/blocs/pos/pos_bloc.dart';
import 'package:ecuisinetab/Transactions/blocs/voucher_bloc/voucher_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Datamodels/Masters/Inventory/InventoryItemDataModel.dart';
import '../../Transactions/InventoryItem/bloc/inventory_item_detail_bloc.dart';
import 'pos_item_detail.dart';

class POSCartPage extends StatefulWidget {
  POSCartPage({Key? key}) : super(key: key);

  @override
  State<POSCartPage> createState() => _POSCartPageState();
}

class _POSCartPageState extends State<POSCartPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VoucherBloc, VoucherState>(
      builder: (context, state) {
        if (state.status == VoucherEditorStatus.sending) {
          return Column(
            children: [
              Text('Sending Order'),
              CircularProgressIndicator(),
            ],
          );
        } else if (state.status == VoucherEditorStatus.loaded) {
          print('Show Cart');
          return Stack(
            fit: StackFit.expand,
            children: [
              Column(
                children: [
                  Container(
                    height: 50,
                    color: Colors.green,
                    child: const Center(
                      child: Text('Cart'),
                    ),
                  ),
                  Expanded(
                      flex: 8,
                      child: VoucherItemsListing(ItemClicked: (index) async {
                        await openItemDetail(index);
                      })),
                ],
              ),
              Positioned(
                  right: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      print('sending');
                      context.read<VoucherBloc>().add(VoucherRequestSave());
                    },
                  ))
            ],
          );
        }
        return Container(
          child: Center(child: Text('${state.status}')),
        );
      },
      listener: (context, state) async {
        if (state.status == VoucherEditorStatus.sent) {
          print('Order Sent');
          Navigator.of(context).pop();
          context.read<PosBloc>().add(OrderSent());
        } else if (state.status == VoucherEditorStatus.senderror) {
          print('Order Send Error');
          //Dialog to show error
          showDialog(
            context: context,
            builder: (context) => const AlertDialog(
              title: Text('Error Sending Order'),
              content: Text('Please check your internet connection'),
            ),
          );
        } else if (state.status == VoucherEditorStatus.requestSave) {
          bool? confirm = await showDialog<bool?>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Confirm Save'),
                  content: Text('Do you want to save?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text('Yes'),
                    ),
                  ],
                );
              });
          if (confirm ?? false) context.read<VoucherBloc>().add(SaveVoucher());
          //Dialog to show error
        }
      },
    );
  }

  Future<void> openItemDetail(int index) async {
    final item = context
        .read<VoucherBloc>()
        .state
        .voucher!
        .InventoryItems![index]
        .BaseItem;
    final InventoryItemDataModel? itemX =
        await showDialog<InventoryItemDataModel>(
      context: context,
      builder: (context2) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: context.read<VoucherBloc>(),
            ),
            BlocProvider(
              create: (context) => InventoryItemDetailBloc()
                ..add(
                  SetItem(
                    item: item,
                  ),
                ),
            ),
          ],
          child: Dialog(
            elevation: 3,
            alignment: Alignment.center,
            child: POSItemDetailPage(),
          ),
        );
      },
    );
    if (itemX != null) {
      context.read<VoucherBloc>().add(
            UpdateInventoryItemAtIndex(
              index: index,
              inventoryItem: itemX,
            ),
          );
    }
  }
}
