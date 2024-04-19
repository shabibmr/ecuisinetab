import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecuisinetab/Datamodels/HiveModels/PriceList/PriceListMasterHive.dart';
import 'package:ecuisinetab/Login/constants.dart';
import 'package:ecuisinetab/Transactions/blocs/pos/pos_bloc.dart';
import 'package:ecuisinetab/Transactions/blocs/voucher_bloc/voucher_bloc.dart';
import 'package:ecuisinetab/Utils/extensions/double_extension.dart';
import 'package:ecuisinetab/Utils/voucher_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PosTableSelector extends StatefulWidget {
  const PosTableSelector({super.key});

  @override
  State<PosTableSelector> createState() => _PosTableSelectorState();
}

class _PosTableSelectorState extends State<PosTableSelector> {
  final TextEditingController _ctrl = TextEditingController();
  Box<PriceListMasterHive> pBox = Hive.box(HiveTagNames.PriceLists_Hive_Tag);

  @override
  void initState() {
    super.initState();
    // callTimer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // late Timer T;

  double val = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue.shade50,
      body: getBody(),
      // drawer: const SwitchDrawer(),
      appBar: AppBar(
        title: const Text('Select Table'),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              context.read<PosBloc>().add(FetchCurrentOrders());
            },
            icon: const Icon(Icons.refresh),
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {},
            initialValue: 0,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              const PopupMenuItem<int>(
                value: 0,
                child: Text('ALL'),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Delivery'),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text('Take Away'),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text('Dine In'),
              ),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await showPrices();
        },
        label: Builder(builder: (context) {
          var plist = context.select((VoucherBloc bloc) =>
                  bloc.state.voucher?.priceListId?.toString() ?? '3') ??
              "3";
          // print('New plist : $plist');
          return Text(pBox.get(plist)?.priceListName ?? '');
        }),
      ),
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

  BlocConsumer<PosBloc, PosState> getBody() {
    return BlocConsumer<PosBloc, PosState>(
      listener: (context, state) {
        // if (state.status == POSStatus.OrderSelected) {
        //   print('At 98 : ');
        //   if (state.vID == null || state.vID == '') {
        //   } else {
        //     context.read<VoucherBloc>().add(FetchVoucher(
        //           voucherID: state.vID!,
        //           voucherPref: state.vPrefix!,
        //           link: '',
        //           vType: GMVoucherTypes.SalesOrder,
        //         ));
        //   }
        //   // Remove widget from the screen
        //   // Navigator.of(context).pop();
        // }
      },
      builder: (context, state) {
        if (state.status == POSStatus.FetchingOrders) {
          return const Center(
            child: Column(children: [
              CircularProgressIndicator(),
              Text('Fetching Orders')
            ]),
          );
        } else if (state.status == POSStatus.OrdersFetched) {
          return Column(
            children: [
              const RefreshTimeIndicator(),
              Card(
                child: SizedBox(
                  height: 60,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _ctrl,
                            onChanged: (value) {
                              setState(() {});
                            },
                            decoration: const InputDecoration(
                                hintText: 'New Reference'),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _ctrl.text.isNotEmpty,
                        child: IconButton(
                            onPressed: () {
                              int defPrice =
                                  Hive.box(HiveTagNames.Settings_Hive_Tag).get(
                                      Config_Tag_Names.Default_PriceList_Tag,
                                      defaultValue: 3);
                              final String ref = _ctrl.text;
                              if (state.currentOrders!.keys.contains(ref)) {
                                String vNo = state.currentOrders![ref]
                                        ['Voucher_No']
                                    .toString();
                                String vPref = state.currentOrders![ref]
                                        ['Voucher_Prefix']
                                    .toString();
                                context.read<VoucherBloc>().add(FetchVoucher(
                                      voucherID: vNo,
                                      voucherPref: vPref,
                                      link: '',
                                      vType: GMVoucherTypes.SalesOrder,
                                    ));
                                context.read<PosBloc>().add(
                                      OrderSelected(
                                        voucherNo: vNo,
                                        vPrefix: vPref,
                                      ),
                                    );
                              } else {
                                context.read<VoucherBloc>()
                                  ..add(SetEmptyVoucher(
                                    voucherType: GMVoucherTypes.SalesOrder,
                                  ))
                                  ..add(SetPriceList(
                                    priceListID: defPrice,
                                  ))
                                  ..add(SwitchReference(
                                      newReference: _ctrl.text));

                                context
                                    .read<PosBloc>()
                                    .add(const OrderSelected());
                              }

                              // Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.send)),
                      )
                    ],
                  ),
                ),
              ),
              const Expanded(child: TablesGrid()),
            ],
          );
        } else if (state.status == POSStatus.OrderFetchError) {
          return Center(
            child: Column(children: [
              IconButton(
                onPressed: () {
                  print('Refetching Orders');
                },
                icon: const Icon(Icons.refresh),
              ),
              const Text('Fetching Orders')
            ]),
          );
        } else {
          return Container(
            child: Text(state.status.toString()),
          );
        }
      },
    );
  }
}

class SwitchDrawer extends StatelessWidget {
  const SwitchDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green.shade50,
      ),
      width: 300,
      child: Column(children: [
        Builder(builder: (context) {
          bool switchVal = context
              .select((VoucherBloc bloc) => bloc.state.switchOption ?? false);
          print('Val : $switchVal');
          return CheckboxListTile(
            title: const Text("Switch Table"),
            value: switchVal,
            onChanged: (val) {
              context.read<VoucherBloc>().add(
                    SetSwitchState(sState: val!),
                  );
            },
          );
        }),
      ]),
    );
  }
}

class TablesGrid extends StatefulWidget {
  const TablesGrid({super.key});

  @override
  State<TablesGrid> createState() => _TablesGridState();
}

class _TablesGridState extends State<TablesGrid> {
  @override
  Widget build(BuildContext context) {
    Map orders =
        context.select((PosBloc bloc) => bloc.state.currentOrders) ?? {};
    List<String>? tables = context.select((PosBloc bloc) => bloc.state.tables!);

    print('Orders : $orders');

    return Builder(builder: (context) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 80,
        ),
        itemCount: tables?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Card(
              color: orders.keys.contains(tables?[index].toString())
                  ? Colors.red.shade100
                  : null,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: AutoSizeText(tables?[index].toString() ?? '',
                            style: const TextStyle(fontSize: 18)),
                      ),
                    ),
                    Container(
                      child: orders.keys.contains(tables?[index].toString())
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(4, 0, 0, 4),
                                      child: Text(double.parse(
                                              orders[tables?[index].toString()]
                                                      ['Total'] ??
                                                  "0.0")
                                          .inCurrencySmall),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 4, 4),
                                      child: ClockWidget(
                                          timeStamp: DateTime.parse(
                                              orders[tables?[index].toString()]
                                                  ['timestamp'])),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Container(),
                    )
                  ],
                ),
              ),
            ),
            onTap: () {
              print('Table change to ${tables?[index].toString() ?? ''}');
              int defPrice = Hive.box(HiveTagNames.Settings_Hive_Tag)
                  .get(Config_Tag_Names.Default_PriceList_Tag, defaultValue: 3);
              if (orders.keys.contains(tables?[index].toString())) {
                String vNo =
                    orders[tables?[index].toString()]['Voucher_No'].toString();
                String vPref = orders[tables?[index].toString()]
                        ['Voucher_Prefix']
                    .toString();
                print('Order Exist in MAP $vNo');
                context.read<VoucherBloc>().add(FetchVoucher(
                      voucherID: vNo,
                      voucherPref: vPref,
                      link: '',
                      vType: GMVoucherTypes.SalesOrder,
                    ));
                context
                    .read<PosBloc>()
                    .add(OrderSelected(voucherNo: vNo, vPrefix: vPref));
              } else {
                context.read<VoucherBloc>()
                  ..add(SetEmptyVoucher(voucherType: GMVoucherTypes.SalesOrder))
                  ..add(SetPriceList(priceListID: defPrice))
                  ..add(SwitchReference(
                      newReference: tables?[index].toString() ?? ''));
                context.read<PosBloc>().add(const OrderSelected());
              }
              print('Changin POS BLOC');

              // Navigator.of(context).pop();
              // context.read<PosBloc>().add(OrderSelected(
              //     voucherNo: tables?[index]['tableNumber'].toString() ?? '',
              //     vPrefix: tables?[index]['tableNumber'].toString() ?? ''));
            },
          );
        },
      );
    });
  }
}

class ClockWidget extends StatefulWidget {
  const ClockWidget({super.key, required this.timeStamp});
  final DateTime timeStamp;

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  @override
  void initState() {
    super.initState();
    callTimer();
  }

  @override
  void dispose() {
    T.cancel();
    super.dispose();
  }

  late Timer T;

  callTimer() async {
    T = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Duration duration = DateTime.now().difference(widget.timeStamp);
    String hours = duration.inHours > 0
        ? "${duration.inHours.toString().padLeft(2, '0')}:"
        : '';

    return Text('$hours${duration.inMinutes.remainder(60)}');
  }
}

class RefreshTimeIndicator extends StatefulWidget {
  const RefreshTimeIndicator({super.key});

  @override
  State<RefreshTimeIndicator> createState() => _RefreshTimeIndicatorState();
}

class _RefreshTimeIndicatorState extends State<RefreshTimeIndicator> {
  @override
  void initState() {
    super.initState();
    callTimer();
  }

  @override
  void dispose() {
    T.cancel();
    super.dispose();
  }

  late Timer T;

  double val = 0;

  callTimer() async {
    T = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        if (val >= 1) {
          context.read<PosBloc>().add(FetchCurrentOrders());
        }
        val += 0.005;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PosBloc, PosState>(
      listener: (context, state) {
        if (state.status == POSStatus.OrdersFetched) {
          val = 0;
        }
      },
      child: LinearProgressIndicator(
        value: val,
      ),
    );
  }
}
