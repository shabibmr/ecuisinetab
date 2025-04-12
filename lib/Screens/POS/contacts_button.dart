import 'package:ecuisinetab/Transactions/blocs/voucher_bloc/voucher_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../address_book/selector/contact_list_selector.dart';

class ContactsButton extends StatelessWidget {
  const ContactsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              //open contact selector
              showDialog(
                context: context,
                builder: (context) => ContactListSelector(
                  onCreateNew: () {},
                  onEditContact: (contact) {},
                  onContactSelected: (contact) {
                    context
                        .read<VoucherBloc>()
                        .add(SetContact(contact: contact));
                  },
                ),
              );
            },
            icon: const Icon(Icons.person),
          ),
          Builder(builder: (context) {
            final contactName = context.select(
                (VoucherBloc bloc) => bloc.state.voucher?.Contact?.ContactName);
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
    );
  }
}
