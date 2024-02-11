import 'package:ecuisinetab/Datamodels/HiveModels/InventoryItems/InvetoryItemDataModel.dart';
import 'package:ecuisinetab/Datamodels/Masters/Inventory/InventoryItemDataModel.dart';
import 'package:ecuisinetab/Datamodels/Transactions/general_voucher_datamodel.dart';
import 'package:ecuisinetab/Transactions/blocs/voucher_bloc/voucher_bloc.dart';
import 'package:ecuisinetab/Utils/extensions/double_extension.dart';
import 'package:input_quantity/input_quantity.dart';

import '../../Datamodels/HiveModels/InventoryGroups/InventorygroupHiveModel.dart';
import '../../Login/constants.dart';
import '../../Transactions/InventoryItem/bloc/inventory_item_detail_bloc.dart';
import '../../Transactions/blocs/pos/pos_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'pos_item_detail.dart';

class POSInvGroups extends StatefulWidget {
  POSInvGroups({Key? key}) : super(key: key);

  @override
  State<POSInvGroups> createState() => _POSInvGroupsState();
}

class _POSInvGroupsState extends State<POSInvGroups> {
  late Box<InventorygroupHiveModel> gBox;

  final List<InventorygroupHiveModel> _groups = [];

  @override
  void initState() {
    print('init state');
    gBox = Hive.box(HiveTagNames.ItemGroups_Hive_Tag);
    // filter gBox with Group_Type=2 to create _groups;
    for (var item in gBox.values) {
      print('> > > ${item.Group_Name} is ${item.Group_Type}');
      if (item.Group_Type == '2') {
        _groups.add(item);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PosBloc, PosState>(
      builder: (context, state) {
        print('>> len : ${_groups.length}');
        return ListView.builder(
          // scrollDirection: Axis.horizontal,
          itemCount: _groups.length,
          itemBuilder: (listContext, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  print('Selected ${_groups[index].Group_ID}');
                  context.read<PosBloc>().add(GroupSelected(
                      groupID: _groups[index].Group_ID!, index: index));
                  Navigator.of(context).pop();
                },
                child: Card(
                  elevation: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      _groups[index].Group_Name!,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class InvGroupExpansionPanel extends StatefulWidget {
  InvGroupExpansionPanel({Key? key}) : super(key: key);

  @override
  State<InvGroupExpansionPanel> createState() => _InvGroupExpansionPanelState();
}

class _InvGroupExpansionPanelState extends State<InvGroupExpansionPanel> {
  Box<InventorygroupHiveModel> gBox =
      Hive.box(HiveTagNames.ItemGroups_Hive_Tag);
  Box<InventoryItemHive> itemsBox = Hive.box(HiveTagNames.Items_Hive_Tag);
  late final List<InventorygroupHiveModel> _groups;
  @override
  void initState() {
    super.initState();
    _groups = gBox.values.where((element) {
      return element.Group_Type == '2';
    }).toList()
      ..forEach((element) {
        _exp[element.Group_ID!] = true;
      });
  }

  final Map<String, bool> _exp = {};
  @override
  Widget build(BuildContext context) {
    print('Build this Groups.. ');

    return SingleChildScrollView(
      child: ExpansionPanelList(
        expansionCallback: (panelIndex, isExpanded) {
          print('expaned :? ${isExpanded}');
          setState(() {
            _exp[_groups[panelIndex].Group_ID!] = isExpanded;
            // _exp.putIfAbsent(panelIndex, () => !isExpanded);
            print(_groups[panelIndex].Group_ID!);
            print(_exp[_groups[panelIndex].Group_ID!]);
          });
        },
        children: _groups.map<ExpansionPanel>(
          (e) {
            print('e');
            print(e.Group_ID);
            print(_exp[e.Group_ID]);
            return ExpansionPanel(
              canTapOnHeader: true,
              headerBuilder: (context, isExpanded) {
                return Container(
                  decoration: kBoxDecorationStyle,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                        child: AutoSizeText(
                          e.Group_Name!,
                          textAlign: TextAlign.left,
                          style: kDashListStyle,
                        ),
                      ),
                    ),
                  ),
                );
              },
              // backgroundColor: Colors.green.shade50,
              body: ItemsExpBody(
                  items: itemsBox.values.where((element) {
                // print('${element.Group_Id} to ${event.groupID}');
                return element.Group_Id == e.Group_ID &&
                    element.isSalesItem == true;
              }).toList()),
              isExpanded: _exp[e.Group_ID] ?? false,
            );
          },
        ).toList(),
      ),
    );
  }
}

class ItemsExpBody extends StatelessWidget {
  ItemsExpBody({Key? key, required this.items}) : super(key: key);
  // final InventorygroupHiveModel grp;
  final List items;
  Box<InventoryItemHive> itemsBox = Hive.box(HiveTagNames.Items_Hive_Tag);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return InvItemListExp(
          item: items[index],
          index: index,
        );
      },
    );

    // Column(
    //   children: itemsBox.values
    //       .where((element) {
    //         // print('${element.Group_Id} to ${event.groupID}');
    //         return element.Group_Id == grp.Group_ID &&
    //             element.isSalesItem == true;
    //       })
    //       .toList()
    //       .map((e) => InvItemListExp(
    //             item: e,
    //             index: i++,
    //           ))
    //       .toList(),
    // );
  }
}

class InvItemListExp extends StatelessWidget {
  const InvItemListExp({super.key, required this.item, required this.index});
  final InventoryItemHive item;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final voucher = context.read<VoucherBloc>().state.voucher;
      // context.select((VoucherBloc bloc) => bloc.state.voucher);
      num qty = voucher?.getItemCurrCount(item.Item_ID!) ?? 0;
      int dec = item.uomObjects[0].UOM_decimal_Points ?? 0;

      // print(
      //     '................................................... Voucher Changed!!');

      return InkWell(
        onTap: () async {
          // Open Item Detail;
          // final voucher = context.read<VoucherBloc>().state.voucher;
          // num qty = voucher?.getItemCurrCount(widget.item.Item_ID!) ?? 0;
          // int dec = widget.item.uomObjects[0].UOM_decimal_Points ?? 0;
          if (qty > 0) {
            print(' Qty is $qty');
          }
          if (qty == 0) {
            qty = 1;
          }
          if (dec == 0) {
            await openItemDetail(context, voucher, qty + 0.0);
          } else {
            await openItemDetail(context, voucher, qty as double);
          }
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 1, 4, 2),
          child: Card(
            child: ListTile(
              title: Text(item.Item_Name ?? ''),
              subtitle: Text(' ${item.Price?.inCurrency}'),
              // trailing: ItemQty(
              //   item: widget.item,
              //   qtyNum: qty as double,
              // ),
              trailing: SizedBox(
                width: 100,
                child: ItemQty(
                  index: index,
                  item: item,
                  qtyNum: qty,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Future<void> openItemDetail(BuildContext context,
      final GeneralVoucherDataModel? voucher, double qty) async {
    print('>>>>>>> >>>>>>>>>>>>>> QQQ : $qty');
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
                    item: InventoryItemDataModel.fromHive(item)
                        .copyWith(ItemReqUuid: 'X'),
                  ),
                )
                ..add(const SetIndex(index: -1))
                ..add(SetItemQuantity(qty)),
            ),
          ],
          child: Dialog(
            elevation: 3,
            alignment: Alignment.center,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: POSItemDetailPage(),
          ),
        );
      },
    );
    if (itemX != null) {
      num q = voucher!.getItemCurrCount(item.Item_ID!) ?? 0;
      if (itemX.quantity! > 0) {
        context
            .read<VoucherBloc>()
            .add(UpdateItemQty(item: itemX, qty: itemX.quantity!));
      } else {
        context
            .read<VoucherBloc>()
            .add(UpdateItemQty(item: itemX, qty: itemX.quantity!));
      }
    }
  }
}

// class ItemGroupList extends StatefulWidget {
//   ItemGroupList({Key? key}) : super(key: key);

//   @override
//   State<ItemGroupList> createState() => _ItemGroupListState();
// }

// class _ItemGroupListState extends State<ItemGroupList> {
//   Box<InventorygroupHiveModel> gBox =
//       Hive.box(HiveTagNames.ItemGroups_Hive_Tag);
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: gBox.values
//               .where((element) => element.Group_Type == '2')
//               .toList()
//               .map((e) => ItemGroupWidget(grp: e))
//               .toList(),
//         ),
//       ),
//     );
//   }
// }

// class ItemGroupWidget extends StatefulWidget {
//   ItemGroupWidget({Key? key, required this.grp}) : super(key: key);
//   final InventorygroupHiveModel grp;
//   @override
//   State<ItemGroupWidget> createState() => _ItemGroupWidgetState();
// }

// class _ItemGroupWidgetState extends State<ItemGroupWidget> {
//   Box<InventoryItemHive> itemsBox = Hive.box(HiveTagNames.Items_Hive_Tag);
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         child: ExpansionTile(
//           backgroundColor: Colors.grey,
//           initiallyExpanded: true,
//           title: Container(
//             color: Colors.amber,
//             child: Center(
//               child: Text(widget.grp.Group_Name ?? ''),
//             ),
//           ),
//           children: itemsBox.values
//               .where((element) {
//                 // print('${element.Group_Id} to ${event.groupID}');
//                 return element.Group_Id == widget.grp.Group_ID &&
//                     element.isSalesItem == true;
//               })
//               .toList()
//               .map((e) => InvItemList(item: e))
//               .toList(),
//         ),
//       ),
//     );
//   }
// }

// class InvItemList extends StatefulWidget {
//   InvItemList({Key? key, required this.item}) : super(key: key);
//   final InventoryItemHive item;

//   @override
//   State<InvItemList> createState() => _InvItemListState();
// }

// class _InvItemListState extends State<InvItemList> {
//   @override
//   Widget build(BuildContext context) {
//     return Builder(builder: (context) {
//       final voucher = context.select((VoucherBloc bloc) => bloc.state.voucher);
//       num qty = voucher?.getItemCurrCount(widget.item.Item_ID!) ?? 0;
//       int dec = widget.item.uomObjects[0].UOM_decimal_Points ?? 0;
//       if (qty > 0)
//         print(
//             '................................................... Voucher Changed!!');
//       bool flag = Hive.box(HiveTagNames.Settings_Hive_Tag)
//           .get('isArabic', defaultValue: false);
//       return InkWell(
//         onTap: () async {
//           // Open Item Detail;
//           // final voucher = context.read<VoucherBloc>().state.voucher;
//           // num qty = voucher?.getItemCurrCount(widget.item.Item_ID!) ?? 0;
//           // int dec = widget.item.uomObjects[0].UOM_decimal_Points ?? 0;
//           if (qty > 0) {
//             print(' Qty is $qty');
//           }
//           if (qty == 0) {
//             qty = 1;
//           }
//           if (dec == 0) {
//             await openItemDetail(voucher, qty + 0.0);
//           } else {
//             await openItemDetail(voucher, qty as double);
//           }
//         },
//         child: ListTile(
//           title: Text(flag
//               ? (widget.item.Item_Name_Arabic ?? '')
//               : (widget.item.Item_Name ?? '')),
//           subtitle: Text(
//             ' ${widget.item.Price?.toStringAsFixed(2)}',
//             style: kLabelStyle,
//           ),
//           // trailing: ItemQty(
//           //   item: widget.item,
//           //   qtyNum: qty as double,
//           // ),
//           trailing: SizedBox(
//             width: 100,
//             child: ItemQty(
//               item: widget.item,
//               qtyNum: qty,
//               index: 0,
//             ),
//           ),
//         ),
//       );
//     });
//   }

//   Future<void> openItemDetail(
//       final GeneralVoucherDataModel? voucher, double qty) async {
//     print('>>>>>>> >>>>>>>>>>>>>> QQQ : $qty');
//     final InventoryItemDataModel? itemX =
//         await showDialog<InventoryItemDataModel>(
//       context: context,
//       builder: (context2) {
//         return MultiBlocProvider(
//           providers: [
//             BlocProvider.value(
//               value: context.read<VoucherBloc>(),
//             ),
//             BlocProvider(
//               create: (context) => InventoryItemDetailBloc()
//                 ..add(
//                   SetItem(
//                     item: InventoryItemDataModel.fromHive(widget.item)
//                         .copyWith(ItemReqUuid: 'X'),
//                   ),
//                 )
//                 ..add(const SetIndex(index: -1))
//                 ..add(SetItemQuantity(qty)),
//             ),
//           ],
//           child: Dialog(
//             elevation: 3,
//             alignment: Alignment.center,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(8))),
//             child: POSItemDetailPage(),
//           ),
//         );
//       },
//     );
//     if (itemX != null) {
//       num q = voucher!.getItemCurrCount(widget.item.Item_ID!) ?? 0;
//       if (itemX.quantity! > 0) {
//         context
//             .read<VoucherBloc>()
//             .add(UpdateItemQty(item: itemX, qty: itemX.quantity!));
//       } else {
//         context
//             .read<VoucherBloc>()
//             .add(UpdateItemQty(item: itemX, qty: itemX.quantity!));
//       }
//     }
//   }
// }

class ItemQty extends StatefulWidget {
  const ItemQty({
    Key? key,
    required this.qtyNum,
    required this.item,
    required this.index,
  }) : super(key: key);
  final num qtyNum;
  final InventoryItemHive item;
  final int index;

  @override
  State<ItemQty> createState() => _ItemQtyState();
}

class _ItemQtyState extends State<ItemQty> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      // key: ValueKey(widget.index + 9000),
      builder: (context) {
        final voucher =
            context.select((VoucherBloc bloc) => bloc.state.voucher);
        // num qtyNum = voucher?.getItemCurrCount(widget.item.Item_ID!) ?? 0;

        return widget.qtyNum == 0
            ? ElevatedButton(
                onPressed: () {
                  context.read<VoucherBloc>().add(AddInventoryItem(
                      inventoryItem:
                          InventoryItemDataModel.fromHive(widget.item)
                              .copyWith(quantity: 1)));
                },
                child: const Text('Add'),
              )
            : Builder(builder: (context) {
                // print('qty : ${widget.qtyNum}');
                return InputQty(
                  key: UniqueKey(),
                  minVal: 0,
                  isIntrinsicWidth: false,
                  initVal: widget.qtyNum + 0.0,
                  decimalPlaces:
                      widget.item.uomObjects[0].UOM_decimal_Points ?? 0,
                  onQtyChanged: (value) {
                    // print('Qty : $value is of Type : ${value.runtimeType}');
                    context.read<VoucherBloc>().add(UpdateItemQty(
                        item: InventoryItemDataModel.fromHive(widget.item),
                        qty: value + 0.0));
                  },
                );
              });
      },
    );
  }
}
