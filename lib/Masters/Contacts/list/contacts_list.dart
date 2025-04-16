import '../../../Datamodels/HiveModels/address_book/contacts_data_model.dart';
import '../../../Masters/Contacts/editor/bloc/contacts_editor_bloc.dart';
import '../../../Masters/Contacts/editor/contacts_editor_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../Login/constants.dart';

class ContactsListWidget extends StatefulWidget {
  const ContactsListWidget({super.key});

  @override
  State<ContactsListWidget> createState() => _ContactsListWidgetState();
}

class _ContactsListWidgetState extends State<ContactsListWidget> {
  final Box<ContactsDataModel> contactsBox =
      Hive.box(HiveTagNames.Contacts_Hive_Tag);
  final TextEditingController _ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ctrl.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final List contacts = contactsBox.values.toList()
      ..sort((a, b) => a.ContactName!.compareTo(b.ContactName!));
    return Scaffold(
      appBar: AppBar(
        actions: const [],
        title: TextField(
            controller: _ctrl,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search Contact...',
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          ContactsDataModel? val =
              await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
              BlocProvider(
                create: (context) =>
                    ContactsEditorBloc()..add(const SetEmptyContact()),
              )
            ], child: const ContactEditorWidget()),
          ));
          if (val != null) {
            print('Refreshing');
            setState(() {});
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
          child: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return Visibility(
            visible: _ctrl.text.isEmpty ||
                contacts[index]!
                    .ContactName!
                    .toLowerCase()
                    .contains(_ctrl.text.toLowerCase()) ||
                contacts[index]!
                    .PhoneNumber!
                    .toLowerCase()
                    .contains(_ctrl.text.toLowerCase()),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                child: ListTile(
                    title: Text(contacts[index]!.ContactName ?? ""),
                    subtitle: Text(contacts[index]!.PhoneNumber ?? ""),
                    // trailing:
                    //     IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                    onTap: () async {
                      print(
                          '>Clicked at $index : ${contacts[index]?.ContactName}');
                      ContactsDataModel? val =
                          await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MultiBlocProvider(providers: [
                          BlocProvider(
                            create: (context) => ContactsEditorBloc()
                              ..add(SetContact(contact: contacts[index]!)),
                          )
                        ], child: const ContactEditorWidget()),
                      ));
                      if (val != null) {
                        print('Refreshing');
                        setState(() {});
                      }
                    }),
              ),
            ),
          );
        },
      )),
    );
  }
}
