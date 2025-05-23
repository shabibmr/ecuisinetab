import 'package:ecuisinetab/Masters/Contacts/editor/bloc/contacts_editor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Datamodels/HiveModels/address_book/contacts_data_model.dart';
import '../../../Masters/Contacts/editor/contacts_editor_widget.dart';
import 'bloc/contactlist_bloc.dart';

class ContactListSelector extends StatefulWidget {
  final Function(ContactsDataModel) onContactSelected;

  const ContactListSelector({
    super.key,
    required this.onContactSelected,
  });

  @override
  State<ContactListSelector> createState() => _ContactListSelectorState();
}

class _ContactListSelectorState extends State<ContactListSelector> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load initial contacts
    context.read<ContactlistBloc>().add(ContactlistLoadInitial());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search contacts...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                context.read<ContactlistBloc>().add(ContactlistClearSearch());
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          onChanged: (value) {
            if (value.isEmpty) {
              context.read<ContactlistBloc>().add(ContactlistClearSearch());
            } else {
              context
                  .read<ContactlistBloc>()
                  .add(ContactlistSearch(searchQuery: value));
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Create New Contact',
            onPressed: () async => await createContact(),
          ),
        ],
      ),
      body: BlocBuilder<ContactlistBloc, ContactlistState>(
        builder: (context, state) {
          if (state is ContactlistLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ContactlistError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (state is ContactlistSuccess) {
            if (state.contacts.isEmpty) {
              print('No contacts found');
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.people_outline,
                        size: 48, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      state.searchQuery.isEmpty
                          ? 'No contacts found'
                          : 'No contacts match your search',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text('Create New Contact'),
                      onPressed: () async => await createContact(),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              itemCount: state.contacts.length,
              itemBuilder: (context, index) {
                final contact = state.contacts[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      contact.ContactName?.substring(0, 1).toUpperCase() ?? '?',
                    ),
                  ),
                  title: Text(contact.ContactName ?? 'Unnamed Contact'),
                  subtitle: Text(contact.PhoneNumber ?? 'No phone number'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    tooltip: 'Edit Contact',
                    onPressed: () => onEditContact(contact),
                  ),
                  onTap: () {
                    if (contact.ContactName != null &&
                        contact.PhoneNumber != null) {
                      // Show visual feedback
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Selected ${contact.ContactName}'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                      widget.onContactSelected(contact);
                    }
                  },
                );
              },
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<void> createContact() async {
    // Open Dialog ContactEditorScreen for creating a new contact
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => ContactsEditorBloc()
            ..add(SetEmptyContact())
            ..add(SetContactPhone(_searchController.text)),
          child: ContactsEditorPage(),
        );
      },
    );
  }

  void onEditContact(ContactsDataModel contact) {
    // Open Dialog ContactEditorScreen for editing an existing contact
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return BlocProvider(
            create: (context) =>
                ContactsEditorBloc()..add(SetContact(contact: contact)),
            child: ContactsEditorPage(),
          );
        });
  }
}
