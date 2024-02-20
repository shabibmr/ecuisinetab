import 'package:ecuisinetab/Screens/POS/voucher_editor.dart';
import 'package:ecuisinetab/Transactions/blocs/pos/pos_bloc.dart';
import 'package:ecuisinetab/Transactions/blocs/voucher_bloc/voucher_bloc.dart';
import 'package:ecuisinetab/Utils/extensions/double_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Datamodels/HiveModels/PriceList/PriceListMasterHive.dart';
import '../../Datamodels/Masters/Inventory/InventoryItemDataModel.dart';
import '../../Login/constants.dart';
import '../../Transactions/InventoryItem/bloc/inventory_item_detail_bloc.dart';
import '../../widgets/Basic/MText.dart';
import 'pos_item_detail.dart';

class POSCartPage extends StatefulWidget {
  const POSCartPage({super.key});

  @override
  State<POSCartPage> createState() => _POSCartPageState();
}

class _POSCartPageState extends State<POSCartPage> {
  Box<PriceListMasterHive> prices = Hive.box(HiveTagNames.PriceLists_Hive_Tag);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VoucherBloc, VoucherState>(
      builder: (context, state) {
        if (state.status == VoucherEditorStatus.sending) {
          return const Column(
            mainAxisSize: MainAxisSize.min,
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
                    decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        )),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Builder(
                          builder: (context) {
                            final table = context.select((VoucherBloc bloc) =>
                                bloc.state.voucher?.reference);
                            return Text(table ?? '');
                          },
                        ),
                        const Center(
                          child: Text('Cart'),
                        ),
                        const VoucherTotalWidget(),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: VoucherItemsListing(
                      ItemClicked: (index) async {
                        await openItemDetail(index);
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const BillCopyCheckBox(),
                        ElevatedButton(
                          onPressed: () async {
                            await showPrices();
                          },
                          child: Builder(builder: (context) {
                            int plist = context.select((VoucherBloc bloc) =>
                                bloc.state.voucher?.priceListId ?? 3);
                            return Text(
                                prices.get(plist.toString())?.priceListName ??
                                    'Select :$plist');
                          }),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    context
                        .read<VoucherBloc>()
                        .add(const VoucherRequestSaveOrder());
                  },
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    context.read<VoucherBloc>().add(VoucherRequestSaveOrder());
                  },
                ),
              ),
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
        } else if (state.status == VoucherEditorStatus.requestSaveOrder) {
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
          if (confirm ?? false) {
            context.read<VoucherBloc>().add(SaveVoucherOrder());
          }
          //Dialog to show error
        }
      },
    );
  }

  Future<void> showPrices() async {
    Box<PriceListMasterHive> prices =
        Hive.box(HiveTagNames.PriceLists_Hive_Tag);

    await showDialog(
      context: context,
      builder: (context2) {
        return BlocProvider.value(
          value: context.read<VoucherBloc>(),
          child: Dialog(
            elevation: 5,
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: prices.values
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: ListTile(
                              title: Text(e.priceListName!),
                              onTap: () {
                                context.read<VoucherBloc>().add(
                                    SetPriceList(priceListID: e.priceListID!));
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> openItemDetail(int index) async {
    print('opening item detail at $index');
    final item = context
        .read<VoucherBloc>()
        .state
        .voucher!
        .InventoryItems![index]
        .BaseItem;

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
                )
                ..add(
                  SetIndex(index: index),
                ),
            ),
          ],
          child: const POSItemDetailPage(),
        );
      },
    );
  }
}

class VoucherTotalWidget extends StatelessWidget {
  const VoucherTotalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      double? total = context
          .select((VoucherBloc element) => element.state.voucher!.grandTotal);

      return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: MText(
            (total?.inCurrency ?? (0 as double).inCurrency),
            textStyle: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.end,
          )),
        ),
      );
    });
  }
}

class BillCopyCheckBox extends StatelessWidget {
  const BillCopyCheckBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final bool printCopy =
          context.select((VoucherBloc bloc) => bloc.state.printCopy ?? false);
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: printCopy,
              onChanged: (bool? value) {
                context
                    .read<VoucherBloc>()
                    .add(SetPrintCopy(printCopy: value!));
              },
            ),
            Text('Print Copy'),
          ],
        ),
      );
    });
  }
}
