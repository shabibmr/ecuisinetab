import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecuisinetab/Datamodels/HiveModels/PriceList/PriceListMasterHive.dart';
import 'package:ecuisinetab/Login/constants.dart';
import 'package:ecuisinetab/Transactions/blocs/pos/pos_bloc.dart';
import 'package:ecuisinetab/Transactions/blocs/voucher_bloc/voucher_bloc.dart';
import 'package:ecuisinetab/Utils/extensions/double_extension.dart';
import 'package:ecuisinetab/Utils/voucher_types.dart';
import 'package:ecuisinetab/widgets/Search/price_list_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PosTableSelector extends StatefulWidget {
  PosTableSelector({Key? key}) : super(key: key);

  @override
  State<PosTableSelector> createState() => _PosTableSelectorState();
}

class _PosTableSelectorState extends State<PosTableSelector> {
  final TextEditingController _ctrl = TextEditingController();
  Box<PriceListMasterHive> pBox = Hive.box(HiveTagNames.PriceLists_Hive_Tag);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue.shade50,
      body: getBody(),
      appBar: AppBar(
        title: Text('Select Table'),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                context.read<PosBloc>().add(FetchCurrentOrders());
              },
              icon: Icon(Icons.refresh)),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
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
              bloc.state.voucher?.priceListId?.toString() ?? '3');
          print('New plist : $plist');
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
              Card(
                child: Container(
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
                                context.read<PosBloc>().add(OrderSelected(
                                    voucherNo: vNo, vPrefix: vPref));
                              } else {
                                context.read<VoucherBloc>()
                                  ..add(SetEmptyVoucher(
                                    voucherType: GMVoucherTypes.SalesOrder,
                                  ))
                                  ..add(
                                      SwitchReference(newReference: _ctrl.text))
                                  ..add(SetPriceList(priceListID: 3));
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
              Expanded(child: TablesGrid()),
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

class TablesGrid extends StatefulWidget {
  TablesGrid({Key? key}) : super(key: key);

  @override
  State<TablesGrid> createState() => _TablesGridState();
}

class _TablesGridState extends State<TablesGrid> {
  @override
  Widget build(BuildContext context) {
    Map orders =
        context.select((PosBloc bloc) => bloc.state.currentOrders) ?? {};
    List<String>? tables =
        context.select((PosBloc bloc) => bloc.state.tables! ?? []);

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
                          style: TextStyle(fontSize: 18)),
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
                                        .inCurrency),
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

            if (orders.keys.contains(tables?[index].toString())) {
              String vNo =
                  orders[tables?[index].toString()]['Voucher_No'].toString();
              String vPref = orders[tables?[index].toString()]['Voucher_Prefix']
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
                ..add(SetPriceList(priceListID: 3))
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
  }
}

class ClockWidget extends StatefulWidget {
  ClockWidget({Key? key, required this.timeStamp}) : super(key: key);
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
        ? duration.inHours.toString().padLeft(2, '0') + ":"
        : '';

    return Text(
        '$hours${duration.inMinutes.remainder(60)}:${(duration.inSeconds.remainder(60))}');
  }
}
