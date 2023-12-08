import '/Masters/Contacts/editor/bloc/contacts_editor_bloc.dart';
import '/widgets/Basic/MStringText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/Basic/MMultiLineText.dart';

class ContactsEditorPage extends StatefulWidget {
  const ContactsEditorPage({super.key});

  @override
  State<ContactsEditorPage> createState() => _ContactsEditorPageState();
}

class _ContactsEditorPageState extends State<ContactsEditorPage> {
  @override
  Widget build(BuildContext context) {
    return const ContactEditorWidget();
  }
}

class ContactEditorWidget extends StatefulWidget {
  const ContactEditorWidget({super.key});

  @override
  State<ContactEditorWidget> createState() => _ContactEditorWidgetState();
}

class _ContactEditorWidgetState extends State<ContactEditorWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactsEditorBloc, ContactsEditorState>(
      listener: (context, state) async {
        if (state.status == EditorStatus.sent) {
          Navigator.of(context).pop(state.contact);
        } else if (state.status == EditorStatus.confirmSave) {
          bool? confirm = await showDialog<bool?>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Confirm Save'),
                  content: const Text('Do you want to save this contact?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                );
              });
          if (confirm ?? false) {
            context.read<ContactsEditorBloc>().add(const SaveContact());
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Contact Editor'),
          actions: [
            IconButton(
              onPressed: () {
                context.read<ContactsEditorBloc>().add(const ContactsRequestSave());
              },
              icon: const Icon(Icons.save),
            ),
          ],
        ),
        body: Builder(builder: (context) {
          final status =
              context.select((ContactsEditorBloc bloc) => bloc.state.status);
          if (status == EditorStatus.loading) {
            return const Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Loading...'),
                  ),
                ],
              ),
            );
          } else if (status == EditorStatus.sending) {
            return const Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Saving...'),
                  ),
                ],
              ),
            );
          } else if (status == EditorStatus.loaded) {
            return const ContactEditorBody();
          } else {
            return Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Error Status : $status'),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}

class ContactEditorBody extends StatefulWidget {
  const ContactEditorBody({super.key});

  @override
  State<ContactEditorBody> createState() => _ContactEditorBodyState();
}

class _ContactEditorBodyState extends State<ContactEditorBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          ContactNameWidget(),
          ContactPhoneWidget(),
          const ContactType(),
          const ContactAddressWidget(),
          const ContactEmailWidget(),
        ],
      ),
    );
  }
}

//1. Contact Name
//2. Phone Number
//3. Email
//4. Address
//5. Type
//6. Ledger

// write a stateless widget to Set Phone Number with textfield ?

class ContactNameWidget extends StatelessWidget {
  ContactNameWidget({super.key});
  final TextEditingController ctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      String val = context.select(
          (ContactsEditorBloc bloc) => bloc.state.contact?.ContactName ?? '');
      print('Name set to $val');
      ctrl.text = val;
      return Card(
        child: MTextField(
          label: 'Name',
          textData: val,
          // controller: TextEditingController()..text = val,
          onChanged: (value) =>
              context.read<ContactsEditorBloc>().add(SetContactName(value)),
        ),
      );
    });
  }
}

class ContactPhoneWidget extends StatelessWidget {
  ContactPhoneWidget({super.key});
  final TextEditingController ctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      String val = context.select(
          (ContactsEditorBloc bloc) => bloc.state.contact?.PhoneNumber ?? '');
      print('Name set to $val');
      ctrl.text = val;
      return Card(
        child: MTextField(
          label: 'Phone Number',
          textData: val,
          // controller: TextEditingController()..text = val,
          onChanged: (value) =>
              context.read<ContactsEditorBloc>().add(SetContactPhone(value)),
        ),
      );
    });
  }
}

class ContactAddressWidget extends StatelessWidget {
  const ContactAddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      String val = context.select(
          (ContactsEditorBloc bloc) => bloc.state.contact?.address ?? '');
      return Card(
        child: MMultiLineTextField(
          label: 'Address',
          textData: val,
          onChanged: (value) =>
              context.read<ContactsEditorBloc>().add(SetContactAddress(val)),
        ),
      );
    });
  }
}

class ContactEmailWidget extends StatelessWidget {
  const ContactEmailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      String val = context
          .select((ContactsEditorBloc bloc) => bloc.state.contact?.email ?? '');
      print('Name set to $val');
      return Card(
        child: MTextField(
          label: 'Email',
          textData: val,
          // controller: TextEditingController()..text = val,
          onChanged: (value) =>
              context.read<ContactsEditorBloc>().add(SetContactEmail(value)),
        ),
      );
    });
  }
}

class ContactType extends StatefulWidget {
  const ContactType({super.key});

  @override
  State<ContactType> createState() => _ContactTypeState();
}

class _ContactTypeState extends State<ContactType> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Select Type'),
              Wrap(
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Customer'),
                      ),
                      Builder(builder: (context) {
                        final value = context.select(
                            (ContactsEditorBloc bloc) =>
                                bloc.state.contact?.Type);
                        return Checkbox(
                          value: value == 1 ? true : false,
                          onChanged: (value) {
                            context
                                .read<ContactsEditorBloc>()
                                .add(const SetContactType(1));
                          },
                        );
                      }),
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Architect'),
                      ),
                      Builder(builder: (context) {
                        final value = context.select(
                            (ContactsEditorBloc bloc) =>
                                bloc.state.contact?.Type);
                        return Checkbox(
                          value: value == 2 ? true : false,
                          onChanged: (value) {
                            context
                                .read<ContactsEditorBloc>()
                                .add(const SetContactType(2));
                          },
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
