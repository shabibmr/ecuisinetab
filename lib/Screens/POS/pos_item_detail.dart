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
  const POSItemDetailPage({super.key});

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
    return Dialog(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAlias,
      child: getB2(),
    );
  }

  Widget getB2() {
    return BlocListener<InventoryItemDetailBloc, InventoryItemDetailState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: Builder(builder: (context) {
        // status: ItemDetailStatus.ready,
        final status =
            context.select((InventoryItemDetailBloc bloc) => bloc.state.status);
        if (status == ItemDetailStatus.ready) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ItemName(),
                      ),
                    ),
                    Builder(builder: (context) {
                      final item = context.select(
                          (InventoryItemDetailBloc bloc) => bloc.state.item!);

                      return Visibility(
                        visible: (item.quantity ?? 0) > 0,
                        child: IconButton(
                          onPressed: () {
                            context
                                .read<VoucherBloc>()
                                .add(UpdateItemQty(item: item, qty: 0));

                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Card(
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
                    const Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: ItemQty(),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 3,
              ),
              const Expanded(
                flex: 1,
                child: Column(
                  children: [
                    ItemNameArabic(),
                    ItemRateWidget(),
                    ItemNarration(),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Builder(
                  builder: (context) {
                    final InventoryItemDataModel item = context.select(
                        (InventoryItemDetailBloc blox) => blox.state.item!);
                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const ItemTotalWidget(),
                        FloatingActionButton(
                          // backgroundColor: Colors.black,
                          onPressed: () {
                            context.read<VoucherBloc>().add(
                                UpdateItemQty(item: item, qty: item.quantity!));
                            // Navigator.of(context).pop>()
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
                            Icons.check,
                            // color: Colors.lightGreen,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return Text('${status}');
        }
      }),
    );
  }
}

class ItemQty extends StatelessWidget {
  const ItemQty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Quantity', style: kSmallStyle),
              ),
              Builder(builder: (context) {
                double? qty = context.select(
                    (InventoryItemDetailBloc element) =>
                        element.state.item?.quantity ?? 0);
                int dec = context.select((InventoryItemDetailBloc element) =>
                    element.state.item?.uomObject?.UOM_decimal_Points ?? 0);
                // Fixed type error
                num qtyNum = qty ?? 0;

                return Builder(builder: (context) {
                  return InputQty(
                    decimalPlaces: dec,
                    minVal: 0,
                    initVal: qtyNum,
                    onQtyChanged: (value) {
                      context
                          .read<InventoryItemDetailBloc>()
                          .add(SetItemQuantity(value.toDouble()));
                    },
                  );
                });
              }),
            ],
          ),
        ],
      ),
    );
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: MText(
            'Total : ${itemTotal?.inCurrency ?? (0 as double).inCurrency}',
            textStyle: kTotalListStyle,
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
      return AutoSizeText(
        itemName ?? '',
        style: kAppbarLabelStyle,
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
      print('narration $narration');
      return Card(
        child: TextFormField(
          maxLines: 3,
          decoration: InputDecoration(hintText: "Narration"),
          initialValue: narration,
          onChanged: (value) {
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
      final String itemNameArabic = context.select(
              (InventoryItemDetailBloc bloc) =>
                  bloc.state.item?.ItemNameArabic) ??
          '';
      return itemNameArabic.length > 0
          ? Text(
              itemNameArabic ?? '',
              style: kTotalListStyle,
            )
          : Container();
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
