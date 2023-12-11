import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../widgets/Basic/MText.dart';
import '../../../../Transactions/blocs/voucher_bloc/voucher_bloc.dart';

class VoucherNumberWidget extends StatelessWidget {
  const VoucherNumberWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      print('no : ${context.read<VoucherBloc>().state.voucher?.voucherNumber}');
      final vNo = context.select((VoucherBloc element) =>
          '${element.state.voucher?.VoucherPrefix} -  ${element.state.voucher?.voucherNumber == "" ? "#" : element.state.voucher?.voucherNumber ?? ''}');

      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MText(
            '$vNo',
            textStyle: TextStyle(fontSize: 20),
          ),
        ),
      );
    });
  }
}
