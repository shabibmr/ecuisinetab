import 'package:ecuisinetab/Transactions/blocs/pos/pos_bloc.dart';
import 'package:ecuisinetab/Transactions/blocs/voucher_bloc/voucher_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class POSCartPage extends StatefulWidget {
  POSCartPage({Key? key}) : super(key: key);

  @override
  State<POSCartPage> createState() => _POSCartPageState();
}

class _POSCartPageState extends State<POSCartPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VoucherBloc, VoucherState>(
      builder: (context, state) {
        if (state.status == VoucherEditorStatus.loaded) {
          print('Show Cart');
          //Show Cart
        }
        return Container();
      },
      listener: (context, state) {
        if (state.status == VoucherEditorStatus.sent) {
          print('Order Sent');
          context.read<PosBloc>().add(OrderSent());
        } else if (state.status == VoucherEditorStatus.sending) {
          print('Sending Order');
          //Dialog to show sending order
          showDialog(
            context: context,
            builder: (context) => const AlertDialog(
              title: Text('Sending Order'),
              content: CircularProgressIndicator(),
            ),
          );
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
        }
      },
    );
  }
}
