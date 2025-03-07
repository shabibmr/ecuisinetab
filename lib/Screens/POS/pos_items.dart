import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecuisinetab/Datamodels/HiveModels/InventoryItems/InvetoryItemDataModel.dart';
import 'package:ecuisinetab/Utils/extensions/double_extension.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:input_quantity/input_quantity.dart';

import '../../Datamodels/HiveModels/InventoryGroups/InventorygroupHiveModel.dart';
import '../../Datamodels/Masters/Inventory/InventoryItemDataModel.dart';
import '../../Login/constants.dart';
import '../../Transactions/InventoryItem/bloc/inventory_item_detail_bloc.dart';
import '../../Transactions/blocs/pos/pos_bloc.dart';
import '../../Transactions/blocs/voucher_bloc/voucher_bloc.dart';
import 'pos_item_detail.dart';

class POSItemsListWidget extends StatefulWidget {
  const POSItemsListWidget({super.key});

  @override
  State<POSItemsListWidget> createState() => _POSItemsListWidgetState();
}

class _POSItemsListWidgetState extends State<POSItemsListWidget> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final status =
          context.select((PosBloc bloc) => bloc.state.itemsLoadStaus);
      print('NEW LOAD STAT $status');
      if (status == SyncStatus.ItemsLoading) {
        return const Center(child: CircularProgressIndicator());
      } else {
        print('whaaaat???');
        final List<InventoryItemHive> items =
            context.select((PosBloc bloc) => bloc.state.items) ?? [];
        print('Items added : ${items.length} ');
        if (items.isEmpty) {
          return const Center(child: Text('No Items Found'));
        } else {
          return Builder(builder: (context) {
            int pId = context.select(
                (VoucherBloc bloc) => bloc.state.voucher?.priceListId ?? 0);
            return ListView.builder(
              // shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                double rate = items[index].Price ?? 0;
                if (pId != 0) {
                  rate = items[index].prices?[pId]?.rate ?? rate;
                }

                return InkWell(
                  onTap: () async {
                    await openItemDetail(items[index]);
                  },
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 65,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  items[index].Item_Name ?? '',
                                  style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  ' ${rate.inCurrencySmall}',
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 35, child: InvQtyWidget(item: items[index])),
                      ],
                    ),
                  ),
                );
              },
            );
          });
        }
      }
    });
  }

  Future<void> openItemDetail(final InventoryItemHive item) async {
    await showDialog<InventoryItemDataModel>(
      context: context,
      builder: (context2) {
        final voucher = context.read<VoucherBloc>().state.voucher;
        final double qty =
            (voucher?.getItemCurrCount(item.Item_ID ?? '') ?? 0) + 0.0;
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: context.read<VoucherBloc>(),
            ),
            BlocProvider(
              create: (context) => InventoryItemDetailBloc()
                ..add(
                  SetItem(
                    item: InventoryItemDataModel.fromHive(item)
                        .copyWith(ItemReqUuid: 'X'),
                  ),
                )
                ..add(const SetIndex(index: -1))
                ..add(SetItemPriceLevel(priceID: voucher!.priceListId ?? 0))
                ..add(SetItemQuantity(qty == 0 ? 1 : qty)),
            ),
          ],
          child: const POSItemDetailPage(),
        );
      },
    );
  }
}

class InvQtyWidget extends StatefulWidget {
  const InvQtyWidget({super.key, required this.item});
  final InventoryItemHive item;

  @override
  State<InvQtyWidget> createState() => _InvQtyWidgetState();
}

class _InvQtyWidgetState extends State<InvQtyWidget> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final double qty = context.select((VoucherBloc bloc) =>
              bloc.state.voucher?.getItemCurrCount(widget.item.Item_ID!) ?? 0) +
          0.0;

      return Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              // InputQty(
              //   decimalPlaces: widget.item.uomObjects[0].UOM_decimal_Points ?? 0,
              //   initVal: qty,
              //   onQtyChanged: (qty) => context.read<VoucherBloc>().add(
              //         UpdateItemQty(
              //           item: InventoryItemDataModel.fromHive(widget.item),
              //           qty: qty,
              //         ),
              //       ),
              (qty == 0)
                  ? Text('Add',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                            qty > 0 ? FontWeight.bold : FontWeight.normal,
                      ))
                  : Text(
                      qty.toStringAsFixed(
                          widget.item.uomObjects[0].UOM_decimal_Points ?? 0),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight:
                            qty > 0 ? FontWeight.bold : FontWeight.normal,
                      )),
        ),
      );
    });
  }
}

class PosGroupsHorizontal extends StatefulWidget {
  const PosGroupsHorizontal({super.key});

  @override
  State<PosGroupsHorizontal> createState() => _PosGroupsHorizontalState();
}

class _PosGroupsHorizontalState extends State<PosGroupsHorizontal> {
  late Box<InventorygroupHiveModel> gBox;

  final List<InventorygroupHiveModel> _groups = [];

  @override
  void initState() {
    gBox = Hive.box(HiveTagNames.ItemGroups_Hive_Tag);
    // filter gBox with Group_Type=2 to create _groups;
    for (var item in gBox.values) {
      if (item.Group_Type == '2') {
        _groups.add(item);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _groups.length,
      itemBuilder: (listContext, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<PosBloc, PosState>(
            builder: (context, state) {
              final selectedIndex = state.currentGroupID;
              return Card(
                elevation: 1,
                color: selectedIndex == _groups[index].Group_ID
                    ? Colors.amber
                    : Colors.green.shade100,
                child: InkWell(
                  onTap: () {
                    context.read<PosBloc>().add(GroupSelected(
                        groupID: _groups[index].Group_ID!, index: index));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Container(
                          color: Colors.green.shade50,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AutoSizeText(
                                _groups[index].Group_Name!,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
