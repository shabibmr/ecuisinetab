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
    List<Map>? tables =
        context.select((PosBloc bloc) => bloc.state.currentOrders);

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: tables?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          child: Container(
            color: Colors.blue,
            child: Text(tables?[index]['tableNumber'].toString() ?? ''),
          ),
          onTap: () {
            context.read<PosBloc>().add(OrderSelected(
                voucherNo: tables?[index]['tableNumber'].toString() ?? '',
                vPrefix: tables?[index]['tableNumber'].toString() ?? ''));
          },
        );
      },
    );
  }
}
