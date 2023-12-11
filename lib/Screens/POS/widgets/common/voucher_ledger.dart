import '../../../../../../Datamodels/HiveModels/Ledgers/LedMasterHiveModel.dart';
import '../../../../../../Datamodels/HiveModels/address_book/contacts_data_model.dart';
import '../../../../../../widgets/Search/contact_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../Datamodels/Masters/Accounts/LedgerMasterDataModel.dart';
import '../../../../../../widgets/Search/ledger_search.dart';
import '../../../../Transactions/blocs/voucher_bloc/voucher_bloc.dart';

class VoucherLedger extends StatelessWidget {
  const VoucherLedger({
    Key? key,
    required this.label,
    this.filters = const [],
    this.onChanged,
  }) : super(key: key);

  final String label;

  final List filters;

  final ValueChanged<LedgerMasterDataModel>? onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var ledger = await showSearch<LedgerMasterHiveModel?>(
          context: context,
          delegate: LedgerSearchDelegate(filters: filters),
        );
        if (ledger != null) {
          onChanged!(LedgerMasterDataModel(
            LedgerID: ledger.LEDGER_ID,
            LedgerName: ledger.Ledger_Name,
          ));
          context.read<VoucherBloc>().add(
                SetMainLedger(
                  ledger: LedgerMasterDataModel(
                    LedgerID: ledger.LEDGER_ID,
                    LedgerName: ledger.Ledger_Name,
                  ),
                ),
              );
        }
      },
      child: Builder(builder: (context) {
        String? id = context.select((VoucherBloc bloc) =>
            bloc.state.voucher?.ledgerObject?.LedgerID ?? '');
        String? name = context.select((VoucherBloc bloc) =>
            bloc.state.voucher?.ledgerObject?.LedgerName ?? '');

        // print('led New Building $name');
        return Card(
          color: Colors.indigoAccent,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('$label : ${name != null ? name : ''}'),
              ),
            ],
          ),
        );
      }),
    );
  }
}

// class ContactCard extends StatelessWidget {
//   const ContactCard({
//     Key? key,
//     this.onChanged,
//     this.label = 'Contact',
//   }) : super(key: key);
//   final ValueChanged<ContactsDataModel>? onChanged;
//   final String label;
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () async {
//         var contact = await showSearch<ContactsDataModel?>(
//           context: context,
//           delegate: ContactSearchDelegate(),
//         );
//         if (contact != null) {
//           onChanged!(contact);
//           context.read<VoucherBloc>().add(
//                 SetContact(
//                   contact: contact,
//                 ),
//               );
//         }
//       },
//       child: Builder(builder: (context) {
//         String? name = context
//             .select((VoucherBloc bloc) => bloc.state.voucher?.POCName ?? '');
//         String? phone = context
//             .select((VoucherBloc bloc) => bloc.state.voucher?.POCPhone ?? '');

//         return Card(
//           color: Colors.indigoAccent,
//           child: Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text('$label : ${name != null ? name : ''}'),
//               ),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text('$phone'),
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }
