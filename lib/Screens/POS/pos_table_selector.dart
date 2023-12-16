import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecuisinetab/Transactions/blocs/pos/pos_bloc.dart';
import 'package:ecuisinetab/Transactions/blocs/voucher_bloc/voucher_bloc.dart';
import 'package:ecuisinetab/Utils/voucher_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PosTableSelector extends StatefulWidget {
  PosTableSelector({Key? key}) : super(key: key);

  @override
  State<PosTableSelector> createState() => _PosTableSelectorState();
}

class _PosTableSelectorState extends State<PosTableSelector> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<PosBloc, PosState>(
      listener: (context, state) {
        if (state.status == POSStatus.OrderSelected) {
          if (state.vID == null || state.vID == '') {
            context.read<VoucherBloc>().add(SetEmptyVoucher(
                  voucherType: GMVoucherTypes.SalesOrder,
                ));
          } else {
            context.read<VoucherBloc>().add(FetchVoucher(
                  voucherID: state.vID!,
                  voucherPref: state.vPrefix!,
                  link: '',
                  vType: GMVoucherTypes.SalesOrder,
                ));
          }
          // Remove widget from the screen
          Navigator.of(context).pop();
        }
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
          return TablesGrid();
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
    ));
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
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: Card(
              child: Container(
                height: 80,
                color: Colors.blue,
                child: AutoSizeText(tables?[index].toString() ?? ''),
              ),
            ),
            onTap: () {
              print('Table change to ${tables?[index].toString() ?? ''}');
              if (orders.keys.contains(tables?[index].toString())) {
                String vNo =
                    orders[tables?[index].toString()]['Voucher_No'].toString();
                String vPref = orders[tables?[index].toString()]
                        ['Voucher_Prefix']
                    .toString();
                context.read<VoucherBloc>().add(FetchVoucher(
                      voucherID: vNo,
                      voucherPref: vPref,
                      link: '',
                      vType: GMVoucherTypes.SalesOrder,
                    ));
              } else {
                context.read<VoucherBloc>().add(SwitchReference(
                    newReference: tables?[index].toString() ?? ''));
              }
              Navigator.of(context).pop();
              // context.read<PosBloc>().add(OrderSelected(
              //     voucherNo: tables?[index]['tableNumber'].toString() ?? '',
              //     vPrefix: tables?[index]['tableNumber'].toString() ?? ''));
            },
          ),
        );
      },
    );
  }
}
