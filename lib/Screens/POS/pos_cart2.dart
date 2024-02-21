import 'package:ecuisinetab/Datamodels/HiveModels/Employee/EmployeeHiveModel.dart';
import 'package:ecuisinetab/Screens/POS/pos_item_detail.dart';
import 'package:ecuisinetab/Transactions/InventoryItem/bloc/inventory_item_detail_bloc.dart';
import 'package:ecuisinetab/Utils/extensions/double_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Datamodels/HiveModels/PriceList/PriceListMasterHive.dart';
import '../../Login/constants.dart';
import '../../Transactions/blocs/pos/pos_bloc.dart';
import '../../Transactions/blocs/voucher_bloc/voucher_bloc.dart';
import 'voucher_editor.dart';

class POSCartPage extends StatefulWidget {
  const POSCartPage({super.key});

  @override
  State<POSCartPage> createState() => _POSCartPageState();
}

class _POSCartPageState extends State<POSCartPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<VoucherBloc, VoucherState>(
      listener: (context, state) async {
        if (state.status == VoucherEditorStatus.sent) {
          Navigator.of(context).pop();
          context.read<PosBloc>().add(OrderSent());
        } else if (state.status == VoucherEditorStatus.validationError) {
          //Dialog to show error

          showDialog(
            context: context,
            builder: (contextB) => AlertDialog(
              title: const Text('Error Sending Sales Voucher'),
              content: Text(state.msg!),
              actions: [
                TextButton(
                  child: const Text('Retry'),
                  onPressed: () {
                    context.read<VoucherBloc>().add(const SaveVoucherInvoice());
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          );
        } else if (state.status == VoucherEditorStatus.senderror) {
          //Dialog to show error
          showDialog(
            context: context,
            builder: (context) => const AlertDialog(
              title: Text('Error Sending Order'),
              content: Text('Please check your internet connection'),
            ),
          );
        } else if (state.status == VoucherEditorStatus.requestSaveOrder) {
          await showDialog<bool?>(
              context: context,
              builder: (contextA) {
                return AlertDialog(
                  title: const Text('Confirm Save'),
                  content: const Text('Do you want to save?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(contextA).pop(false);
                        context
                            .read<VoucherBloc>()
                            .add(const SaveVoucherOrder());
                      },
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(contextA).pop(true);
                        context
                            .read<VoucherBloc>()
                            .add(const SaveVoucherOrder());
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                );
              });
          // if (confirm ?? false) {
          //   context.read<VoucherBloc>().add(const SaveVoucher());
          // }
        } else if (state.status == VoucherEditorStatus.requestSaveInvoice) {
          await showDialog<bool?>(
              context: context,
              builder: (contextA) {
                return AlertDialog(
                  backgroundColor: Color.fromRGBO(244, 98, 45, 0.811),
                  title: const Text('Confirm Checkout'),
                  content: const Text('Do you want to save as Sale ?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(contextA).pop(false);
                      },
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(contextA).pop(true);
                        context
                            .read<VoucherBloc>()
                            .add(const SaveVoucherInvoice());
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                );
              });
          // if (confirm ?? false) {
          //   context.read<VoucherBloc>().add(const SaveVoucher());
          // }
        }
      },
      child: const POSCartWidget(),
    );
  }
}

class POSCartWidget extends StatelessWidget {
  const POSCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          IconButton(
              onPressed: () {
                context
                    .read<VoucherBloc>()
                    .add(const VoucherRequestSaveInvoice());
              },
              icon: const Icon(
                Icons.currency_rupee_rounded,
              ))
        ],
      ),
      body: Column(
        children: [
          const Expanded(flex: 1, child: VoucherHeaderDetails()),
          const Expanded(flex: 8, child: CartItemsList()),
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                      flex: 4,
                      child: VoucherFooter(
                        show: false,
                      )),
                  Expanded(
                    flex: 6,
                    child: Row(
                      children: [
                        Card(
                          color: context.select((VoucherBloc bloc) =>
                                  bloc.state.printCopy ?? false)
                              ? Colors.green.shade300
                              : Colors.red.shade100,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.print,
                                      color: context.select(
                                              (VoucherBloc bloc) =>
                                                  bloc.state.printCopy ?? false)
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text('Print',
                                        style: TextStyle(
                                          color: context.select(
                                                  (VoucherBloc bloc) =>
                                                      bloc.state.printCopy ??
                                                      false)
                                              ? Colors.black
                                              : Colors.grey,
                                        )),
                                  ],
                                ),
                                Checkbox(
                                  value: context.select((VoucherBloc bloc) =>
                                      bloc.state.printCopy ?? false),
                                  onChanged: (v) => context
                                      .read<VoucherBloc>()
                                      .add(SetPrintCopy(printCopy: v ?? false)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<VoucherBloc>().add(
                const VoucherRequestSaveOrder(),
              );
        },
        child: const Icon(Icons.send),
      ),
    );
  }
}

class VoucherHeaderDetails extends StatelessWidget {
  const VoucherHeaderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        VoucherReferenceWidget(),
        PriceListWidget(),
        VoucherSalesmanWidget(),
      ],
    );
  }
}

class VoucherReferenceWidget extends StatelessWidget {
  const VoucherReferenceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      String ref = context
          .select((VoucherBloc bloc) => bloc.state.voucher?.reference ?? '');
      String vno = context.select(
          (VoucherBloc bloc) => bloc.state.voucher?.voucherNumber ?? '');

      String vtype = context
          .select((VoucherBloc bloc) => bloc.state.voucher?.voucherType ?? '');

      return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('$ref - $vno - $vtype'),
        ),
      );
    });
  }
}

class VoucherSalesmanWidget extends StatelessWidget {
  const VoucherSalesmanWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final int? salesman =
          context.select((VoucherBloc bloc) => bloc.state.voucher?.SalesmanID);
      final Box<EmployeeHiveModel> employees =
          Hive.box(HiveTagNames.Employee_Hive_Tag);
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(employees.get(salesman)!.UserName ?? ''),
        ),
      );
    });
  }
}

class VoucherTotalsWidget extends StatelessWidget {
  const VoucherTotalsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final double total = context
          .select((VoucherBloc bloc) => bloc.state.voucher?.grandTotal ?? 0);
      return Padding(
        padding: const EdgeInsets.all(12),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              total.inCurrency,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
      );
    });
  }
}

class PriceListWidget extends StatefulWidget {
  const PriceListWidget({super.key});

  @override
  State<PriceListWidget> createState() => _PriceListWidgetState();
}

class _PriceListWidgetState extends State<PriceListWidget> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      int plist = context
          .select((VoucherBloc bloc) => bloc.state.voucher?.priceListId ?? 3);
      Box<PriceListMasterHive> prices =
          Hive.box(HiveTagNames.PriceLists_Hive_Tag);
      return ElevatedButton(
        onPressed: () => showPrices(prices),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              prices.get(plist.toString())?.priceListName ?? 'Select :$plist'),
        ),
      );
    });
  }

  Future<void> showPrices(final Box<PriceListMasterHive> prices) async {
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
}

class CartItemsList extends StatelessWidget {
  const CartItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    // print('Building CartItemsList ');
    return BlocProvider(
      create: (context) => InventoryItemDetailBloc(),
      child: BlocBuilder<VoucherBloc, VoucherState>(
        builder: (context, state) {
          print('new list state');
          if (state.voucher!.InventoryItems!.isEmpty) {
            return const Center(
              child: Text('No Items'),
            );
          } else {
            return ListView.builder(
              key: UniqueKey(),
              itemCount: state.voucher!.InventoryItems!.length,
              itemBuilder: (context, index) {
                final e = state.voucher!.InventoryItems![index];
                return Card(
                  child: InkWell(
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (contextB) {
                            final item = e.BaseItem;
                            return MultiBlocProvider(
                              providers: [
                                BlocProvider.value(
                                  value: context.read<VoucherBloc>(),
                                ),
                                BlocProvider.value(
                                    value:
                                        context.read<InventoryItemDetailBloc>()
                                          ..add(
                                            SetItem(item: item),
                                          )
                                          ..add(SetIndex(index: index))),
                              ],
                              child: const POSItemDetailPage(),
                            );
                          });
                    },
                    child: ListTile(
                      title: Text(e.BaseItem.ItemName!),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(e.BaseItem.rate?.inCurrency ?? ''),
                          Text(e.BaseItem.grandTotal?.inCurrency ?? '')
                        ],
                      ),
                      trailing: Text(
                          e.BaseItem.quantity?.toStringAsFixed(2) ?? '0.00'),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class POSCartListItem extends StatelessWidget {
  const POSCartListItem({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: ValueKey('CartItem$index'),
      onTap: () async {
        await showDialog(
            context: context,
            builder: (contextB) {
              final item = context
                  .read<VoucherBloc>()
                  .state
                  .voucher!
                  .InventoryItems![index]
                  .BaseItem;
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
            });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text('${index + 1}. '),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: POSCartListItemName(index: index),
                    ),
                    POSCartListItemPrice(index: index),
                  ],
                ),
              ),
              Expanded(flex: 2, child: POSCartListItemQty(index: index)),
              Expanded(flex: 3, child: POSCartListItemTotal(index: index)),
            ],
          ),
        ),
      ),
    );
  }
}

class POSCartListItemName extends StatelessWidget {
  const POSCartListItemName({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      String itemName = context.select((VoucherBloc bloc) =>
          bloc.state.voucher?.InventoryItems?[index].BaseItem.ItemName ?? '');
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(itemName),
      );
    });
  }
}

class POSCartListItemPrice extends StatelessWidget {
  const POSCartListItemPrice({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      double rate = context.select((VoucherBloc bloc) =>
          bloc.state.voucher?.InventoryItems?[index].BaseItem.rate ?? 0);
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(rate.inCurrency),
      );
    });
  }
}

class POSCartListItemQty extends StatelessWidget {
  const POSCartListItemQty({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      double qty = context.select((VoucherBloc bloc) =>
          bloc.state.voucher?.InventoryItems?[index].BaseItem.quantity ?? 0);
      return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(qty.inCurrency),
        ),
      );
    });
  }
}

class POSCartListItemTotal extends StatelessWidget {
  const POSCartListItemTotal({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      double itemName = context.select((VoucherBloc bloc) =>
          bloc.state.voucher?.InventoryItems?[index].BaseItem.grandTotal ?? 0);
      return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(itemName.inCurrency),
        ),
      );
    });
  }
}
