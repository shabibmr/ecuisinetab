import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../widgets/Basic/MDateEdit.dart';
import '../../../../Transactions/blocs/voucher_bloc/voucher_bloc.dart';

class VoucherDateWidget extends StatelessWidget {
  const VoucherDateWidget({
    Key? key,
    this.onChanged,
  }) : super(key: key);

  final ValueChanged<DateTime>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final vDate = context
          .select((VoucherBloc element) => element.state.voucher!.VoucherDate);
      print('New Date set to : ${vDate}');
      return Container(
        child: MDateEdit(
          label: 'Date',
          textStyle: TextStyle(fontSize: 20),
          date: vDate,
          dateChanged: (date) {
            onChanged!(date);
            context.read<VoucherBloc>().add(
                  SetVoucherDate(
                    voucherDate: date,
                  ),
                );
          },
        ),
      );
    });
  }
}
