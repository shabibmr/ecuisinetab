import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecuisinetab/Datamodels/Masters/Inventory/InventoryItemDataModel.dart';
import 'package:ecuisinetab/Login/constants.dart';
import 'package:ecuisinetab/Transactions/blocs/voucher_bloc/voucher_bloc.dart';
import 'package:ecuisinetab/Utils/extensions/double_extension.dart';
import 'package:ecuisinetab/widgets/Basic/MNumText.dart';
import 'package:ecuisinetab/widgets/Basic/MStringText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:input_quantity/input_quantity.dart';

import '../../Transactions/InventoryItem/bloc/inventory_item_detail_bloc.dart';
import '../../widgets/Basic/MMultiLineText.dart';
import '../../widgets/Basic/MText.dart';

class POSItemDetailPage extends StatefulWidget {
  POSItemDetailPage({Key? key}) : super(key: key);

  @override
  State<POSItemDetailPage> createState() => _POSItemDetailPageState();
}

class _POSItemDetailPageState extends State<POSItemDetailPage> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

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
        return SingleChildScrollView(
          child: Scaffold(
            appBar: AppBar(
              title: Text(context.select((InventoryItemDetailBloc bloc) =>
                  bloc.state.item?.ItemName ?? '')),
              centerTitle: false,
            ),
            body: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Card(
                      shadowColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.blue.shade50,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 3,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.yellow.shade50,
                      child: const Column(
                        children: [
                          ItemNameArabic(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(child: ItemRateWidget()),
                              Expanded(child: ItemQty()),
                            ],
                          ),
                          ItemNarration(),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.amber.shade50,
                    child: Builder(
                      builder: (context) {
                        final InventoryItemDataModel item = context.select(
                            (InventoryItemDetailBloc blox) => blox.state.item!);
                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FloatingActionButton(
                              onPressed: () {
                                print('Pressed');
                                int index = context
                                        .read<InventoryItemDetailBloc>()
                                        .state
                                        .index ??
                                    -1;
                                if (index >= 0) {
                                  context.read<VoucherBloc>().add(
                                      RemoveInventoryItemAtIndex(index: index));
                                  Navigator.of(context).pop();
                                }
                              },
                              child: const Icon(Icons.delete),
                            ),
                            const ItemTotalWidget(),
                            FloatingActionButton(
                              onPressed: () {
                                print('Pressed');
                                Navigator.of(context).pop(item);
                              },
                              child: const Icon(Icons.check),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return Text('${status}');
      }
    });
  }
}

class ItemQty extends StatelessWidget {
  const ItemQty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Center(
            child: Builder(builder: (context) {
              double? qty = context.select((InventoryItemDetailBloc element) =>
                  element.state.item?.quantity ?? 0);
              int dec = context.select((InventoryItemDetailBloc element) =>
                  element.state.item?.uomObject?.UOM_decimal_Points ?? 0);
              print('Updating $qty');
              // Fixed type error
              num qtyNum = qty ?? 0;

              return Builder(builder: (context) {
                print('Rebuilding');
                return InputQty.int(
                  minVal: 0,
                  initVal: qtyNum,
                  onQtyChanged: (value) {
                    print('Qty : $value');
                    context
                        .read<InventoryItemDetailBloc>()
                        .add(SetItemQuantity(value.toDouble()));
                  },
                );
              });
            }),
          ),
        ],
      ),
    );
  }
}

class ItemQuantity extends StatefulWidget {
  const ItemQuantity({Key? key, required this.focusNode}) : super(key: key);
  final FocusNode focusNode;

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
      print('New Qty Build');
      return Card(
        child: widget.focusNode.hasFocus
            ? MNumField(
                label: 'Quantity',
                showBorder: true,
                showSuffix: false,
                focusNode: widget.focusNode,
                // focusNode: FocusNode(),
                autoFocus: true,
                selectAllOnClick: true,
                textAlign: TextAlign.right,
                textData: qty?.toStringAsFixed(dec) ?? '0',
                textStyle: Theme.of(context).textTheme.titleLarge,
                readOnly: false,
                onSubmitted: (value) {
                  FocusScope.of(context).unfocus();
                  context
                      .read<InventoryItemDetailBloc>()
                      .add(ItemDetailShowBatchEditor(show: true));
                },
                onChanged: (value) {
                  context
                      .read<InventoryItemDetailBloc>()
                      .add(SetItemQuantity(value.toDouble()));
                },
              )
            : InkWell(
                onTap: () {
                  setState(() {
                    widget.focusNode.requestFocus();
                  });
                },
                child: Text(
                  'Qty : ${qty?.toStringAsFixed(dec)}',
                ),
              ),
      );
    });
  }
}

class ItemTotalWidget extends StatelessWidget {
  const ItemTotalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      double? itemTotal = context.select(
          (InventoryItemDetailBloc element) => element.state.item!.grandTotal);
      return Card(
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: MText(
            'Total : ' + (itemTotal?.inCurrency ?? (0 as double).inCurrency),
            textStyle: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.end,
          )),
        ),
      );
    });
  }
}

class ItemName extends StatelessWidget {
  ItemName({super.key});

  Box sett = Hive.box(HiveTagNames.Settings_Hive_Tag);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      bool flag = sett.get('isArabic', defaultValue: false);
      final String? itemName = context.select((InventoryItemDetailBloc bloc) =>
          flag ? bloc.state.item?.ItemNameArabic : bloc.state.item?.ItemName);
      return Text(
        itemName ?? '',
        // style: kAppbarLabelStyle,
      );
    });
  }
}

class ItemNarration extends StatelessWidget {
  const ItemNarration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      String? narration = context.select(
          (InventoryItemDetailBloc element) => element.state.item!.narration);
      return Card(
        child: MMultiLineTextField(
          label: 'Narration',
          textData: narration,
          textStyle: Theme.of(context).textTheme.titleLarge,
          onChanged: (value) {
            print('Setting narration');
            context
                .read<InventoryItemDetailBloc>()
                .add(SetItemNarration(value));
          },
        ),
      );
    });
  }
}

class ItemNameArabic extends StatelessWidget {
  const ItemNameArabic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final String? itemNameArabic = context.select(
          (InventoryItemDetailBloc bloc) => bloc.state.item?.ItemNameArabic);
      return Text(
        itemNameArabic ?? '',
        style: kTotalListStyle,
      );
    });
  }
}

class ItemRateWidget extends StatelessWidget {
  const ItemRateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      double rate = context.select(
          (InventoryItemDetailBloc element) => element.state.item!.rate!);
      return Card(
        child: MNumField(
          label: 'Rate',
          showSuffix: false,
          showBorder: false,
          textData: rate.inCurrency,
          textAlign: TextAlign.right,
          textStyle: Theme.of(context).textTheme.titleLarge,
          readOnly: true,
          onChanged: (value) {
            context
                .read<InventoryItemDetailBloc>()
                .add(SetItemRate(value.toDouble()));
          },
        ),
      );
    });
  }
}
