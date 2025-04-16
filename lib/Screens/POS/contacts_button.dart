import 'package:ecuisinetab/Screens/address_book/selector/bloc/contactlist_bloc.dart';
import 'package:ecuisinetab/Transactions/blocs/voucher_bloc/voucher_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../address_book/selector/contact_list_selector.dart';

class ContactsButton extends StatelessWidget {
  const ContactsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                //open contact selector
                showDialog(
                  context: context,
                  builder: (contextB) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => ContactlistBloc(),
                      ),
                      BlocProvider.value(
                        value: context.read<VoucherBloc>(),
                      ),
                    ],
                    child: ContactListSelector(
                      onContactSelected: (contact) {
                        print('Set Contact');
                        context
                            .read<VoucherBloc>()
                            .add(SetContact(contact: contact));
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.contacts),
            ),
            Builder(builder: (context) {
              final contactName = context
                  .select((VoucherBloc bloc) => bloc.state.voucher?.POCName);
              if (contactName != null) {
                return Text(
                  contactName,
                  style: Theme.of(context).textTheme.bodyMedium,
                );
              } else {
                return Container();
              }
            }),
          ],
        ),
      ),
    );
  }
}
