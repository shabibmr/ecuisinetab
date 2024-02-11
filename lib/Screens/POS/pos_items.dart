import 'package:ecuisinetab/Screens/POS/pos_cart.dart';
import 'package:ecuisinetab/Screens/POS/pos_item_detail.dart';
import 'package:ecuisinetab/Transactions/InventoryItem/bloc/inventory_item_detail_bloc.dart';
import 'package:ecuisinetab/Utils/extensions/double_extension.dart';

import '../../Datamodels/HiveModels/InventoryItems/InvetoryItemDataModel.dart';

import '../../Datamodels/HiveModels/UOM/UOMHiveModel.dart';
import '../../Datamodels/Masters/Inventory/InventoryItemDataModel.dart';
import '../../Datamodels/Transactions/general_voucher_datamodel.dart';
import '../../Login/constants.dart';

import '../../Transactions/blocs/pos/pos_bloc.dart';
import '../../Transactions/blocs/voucher_bloc/voucher_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Utils/extensions/double_input_formatter.dart';

class POSInvItemsListByGroup extends StatefulWidget {
  POSInvItemsListByGroup({Key? key}) : super(key: key);

  @override
  State<POSInvItemsListByGroup> createState() => _POSInvItemsListByGroupState();
}

class _POSInvItemsListByGroupState extends State<POSInvItemsListByGroup> {
  @override
  Widget build(BuildContext context) {
    return POSItemsListWidget();
  }
}

class POSItemsListWidget extends StatefulWidget {
  POSItemsListWidget({Key? key}) : super(key: key);

  @override
  State<POSItemsListWidget> createState() => _POSItemsListWidgetState();
}

class _POSItemsListWidgetState extends State<POSItemsListWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VoucherBloc, VoucherState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        print('v rebuil');
        if (state.status == VoucherEditorStatus.loaded) {
          return BlocConsumer<PosBloc, PosState>(
            builder: (context, state) {
              print('new State emit ${state.itemsLoadStaus}');

              if (state.itemsLoadStaus == SyncStatus.ItemsLoaded) {
                if (state.items != null) {
                  print('items len : ${state.items!.length}');
                  return getItemTable(state);
                } else {
                  return Text('List null');
                }
              } else if (state.itemsLoadStaus == SyncStatus.ItemsLoading) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      Text('Loading Items'),
                    ],
                  ),
                );
              } else if (state.status == POSStatus.NEW) {
                return const Center(
                  child: Text('Select Group'),
                );
              } else {
                return Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 1)),
                  child: Text(state.toString()),
                );
              }
            },
            listener: (context, state) {},
          );
        } else {
          return Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.red, width: 1)),
            child: Text(state.toString()),
          );
        }
      },
    );
  }

  Widget getItemTable(PosState state) {
    return ListView.builder(
        itemCount: state.items!.length,
        itemBuilder: ((context, index) => getItem(item: state.items![index])));
  }

  Widget getItem({required final InventoryItemHive item}) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: getItemCard(item),
      ),
    );
  }

  Widget getItemCard(InventoryItemHive item) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 7, child: itemDetail(item)),
            Expanded(flex: 3, child: getQty(item)),
          ],
        ),
      ),
    );
  }

  Widget itemDetail(InventoryItemHive item) {
    return InkWell(
      onTap: () async {
        await openItemDetailPage(item);
      },
      child: Container(
        color: Colors.amber.shade50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: AutoSizeText(
                item.Item_Name ?? '',
                style: kNormalStyle,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: AutoSizeText(
                    '@${item.Price?.inCurrency}',
                    style: kSmallStyle,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: AutoSizeText(
                    ' MRP : ${item.Price_2?.toStringAsFixed(2) ?? ''}',
                    style: kSmallStyle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getQty(InventoryItemHive item) {
    num val = context
            .read<VoucherBloc>()
            .state
            .voucher
            ?.getItemCount(item.Item_ID!) ??
        0;

    return InkWell(
      onTap: () async {
        var newval = await getQtyValue(val.toDouble());
        if (newval != null) {
          context.read<VoucherBloc>().add(
                UpdateItemQty(
                  item: InventoryItemDataModel(
                    ItemID: item.Item_ID,
                    ItemName: item.Item_Name,
                    taxRate: item.Vat_Rate,
                    rate: item.Price,
                  ),
                  qty: newval,
                ),
              );
        }
      },
      child: Container(
        color: Colors.blue.shade100,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: AutoSizeText(
              val > 0 ? val.toStringAsFixed(2) : 'BLA',
              style: const TextStyle(
                fontSize: 8,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ),
    );
  }

  Future<double?> getQtyValue(double qty) async {
    double? val = await showDialog(
      context: context,
      builder: (context2) {
        return Dialog(
          elevation: 3,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Container(
                    color: Colors.amber.shade100,
                    child: const Text('Enter Quantity'),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.blue.shade100,
                  child: TextFormField(initialValue: qty.toStringAsFixed(2)),
                ),
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context, 23);
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('OK'))
            ],
          ),
        );
      },
    );
    return val;
  }

  Future<void> openItemDetailPage(InventoryItemHive item) async {
    print('openItemDetailPage');
    num count = context
            .read<VoucherBloc>()
            .state
            .voucher!
            .getItemCount(item.Item_ID!) ??
        0;

    await showDialog(
      context: context,
      builder: (context2) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: context.read<VoucherBloc>(),
          ),
          BlocProvider(
            create: (context) => InventoryItemDetailBloc()
              ..add(SetItem(item: InventoryItemDataModel.fromHive(item))),
          ),
        ],
        child: Dialog(
          elevation: 3,
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)),
          alignment: Alignment.center,
          child: POSItemDetailPage(),
        ),
      ),
    );
  }
}
