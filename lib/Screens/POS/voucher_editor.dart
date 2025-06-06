import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecuisinetab/Utils/extensions/string_extension.dart';

import '../../../../../Datamodels/HiveModels/UOM/UOMHiveModel.dart';
import '../../../../../Datamodels/Masters/Inventory/CompoundItemDataModel.dart';
import '../../../../../Datamodels/Masters/Inventory/InventoryItemDataModel.dart';
import '../../../../../Login/constants.dart';

import 'package:uuid/uuid.dart';
// inventory_item_detail/inventory_item_detail_bloc.dart';
import '../../../../../Transactions/blocs/voucher_bloc/voucher_bloc.dart';
import '../../../../../Utils/extensions/double_extension.dart';
import '../../../../../Utils/voucher_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../Datamodels/HiveModels/InventoryItems/InvetoryItemDataModel.dart';
import '../../../widgets/Search/inventory_item_search.dart';
import 'widgets/common/voucher_date.dart';
import 'widgets/common/voucher_ledger.dart';
import 'widgets/common/voucher_number.dart';

class VoucherHeading extends StatefulWidget {
  VoucherHeading({Key? key}) : super(key: key);

  @override
  State<VoucherHeading> createState() => _VoucherHeadingState();
}

class _VoucherHeadingState extends State<VoucherHeading> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            VoucherNumberWidget(),
            VoucherDateWidget(),
          ],
        ),
      ),
    );
  }
}

class VoucherItemsListing extends StatefulWidget {
  VoucherItemsListing({
    Key? key,
    required this.ItemClicked,
  }) : super(key: key);

  final Function(int) ItemClicked;

  @override
  State<VoucherItemsListing> createState() => _VoucherItemsListingState();
}

class _VoucherItemsListingState extends State<VoucherItemsListing> {
  @override
  Widget build(BuildContext context) {
    final List<CompoundItemDataModel>? items = context
        .select((VoucherBloc element) => element.state.voucher!.InventoryItems);
    if (items == null || items.length == 0) {
      return Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(child: Text('No items'), onPressed: () {}),
          ),
        ),
      );
    } else {
      return ListView.builder(
        key: UniqueKey(),
        itemCount: items.length,
        itemBuilder: (context2, index) {
          return ItemsListItemWidget(
            index: index,
            ItemClicked: widget.ItemClicked,
          );
        },
      );
    }
  }
}

class ItemsListItemWidget extends StatelessWidget {
  const ItemsListItemWidget({
    super.key,
    required this.index,
    required this.ItemClicked,
  });

  final int index;
  final Function(int) ItemClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          ItemClicked(index);
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                // Positioned(
                //     left: 0,
                //     top: 0,
                //     child: Padding(
                //       padding: const EdgeInsets.all(0.0),
                //       child: Text(
                //         '${index + 1}',
                //         style: TextStyle(fontWeight: FontWeight.bold),
                //       ),
                //     )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 0, 4, 0),
                            child: Builder(builder: (context) {
                              bool flag =
                                  Hive.box(HiveTagNames.Settings_Hive_Tag)
                                      .get('isArabic', defaultValue: false);
                              final String? name = context.select(
                                  (VoucherBloc value) => flag
                                      ? (value.state.voucher!.InventoryItems)!
                                          .elementAt(index)
                                          .BaseItem
                                          .ItemNameArabic
                                      : (value.state.voucher!.InventoryItems)!
                                          .elementAt(index)
                                          .BaseItem
                                          .ItemName);
                              return AutoSizeText(
                                name ?? '',
                                style: TextStyle(fontSize: 18),
                              );
                            }),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(8.0, 0, 4, 0),
                                child: Builder(builder: (context) {
                                  final rate = context
                                      .select((VoucherBloc value) =>
                                          value.state.voucher!.InventoryItems)!
                                      .elementAt(index)
                                      .BaseItem
                                      .rate!
                                      .inCurrency;
                                  return AutoSizeText('@ $rate');
                                }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Builder(builder: (context) {
                          final qty = context
                              .select((VoucherBloc value) =>
                                  value.state.voucher!.InventoryItems)!
                              .elementAt(index)
                              .BaseItem
                              .quantity;
                          final decimalPoints = context
                              .select((VoucherBloc value) =>
                                  value.state.voucher!.InventoryItems)!
                              .elementAt(index)
                              .BaseItem
                              .uomObject
                              ?.UOM_decimal_Points;
                          final uomSymbol = context
                              .select((VoucherBloc value) =>
                                  value.state.voucher!.InventoryItems)!
                              .elementAt(index)
                              .BaseItem
                              .uomObject
                              ?.uom_symbol;
                          final quantity =
                              qty?.toStringAsFixed(decimalPoints ?? 0);
                          return AutoSizeText('${quantity} ${uomSymbol ?? ''}');
                        }),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FittedBox(
                            child: Builder(builder: (context) {
                              final gt = context
                                  .select((VoucherBloc value) =>
                                      value.state.voucher!.InventoryItems)!
                                  .elementAt(index)
                                  .BaseItem
                                  .grandTotal!
                                  .inCurrency;
                              return AutoSizeText(
                                gt,
                                style: TextStyle(fontSize: 18),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VoucherFooter extends StatefulWidget {
  const VoucherFooter({super.key, this.show = true});
  final bool show;
  @override
  State<VoucherFooter> createState() => _VoucherFooterState();
}

class _VoucherFooterState extends State<VoucherFooter> {
  @override
  Widget build(BuildContext context) {
    final voucher = context.select((VoucherBloc bloc) => bloc.state.voucher);
    return Card(
      color: Colors.white,
      elevation: 5,
      shadowColor: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Builder(builder: (context) {
                  double totalValue = context.select((VoucherBloc bloc) =>
                      bloc.state.voucher?.grandTotal ?? 0);
                  return AutoSizeText(
                    totalValue.inCurrency,
                    style: kTotalListStyle,
                  );
                }),
              ),
            ),
            Visibility(
              visible: widget.show,
              child: Row(
                children: [
                  const Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                  ),
                  Builder(builder: (context) {
                    int count = context.select((VoucherBloc bloc) =>
                        bloc.state.voucher!.InventoryItems!.length);
                    return AutoSizeText(
                      count > 0 ? count.toString() : '0',
                      style: kTotalListStyle,
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
