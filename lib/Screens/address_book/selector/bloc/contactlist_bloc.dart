import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../Datamodels/HiveModels/address_book/contacts_data_model.dart';
import '../../../../Login/constants.dart';
import '../../../../Webservices/webservicePHP.dart';

part 'contactlist_event.dart';
part 'contactlist_state.dart';

class ContactlistBloc extends Bloc<ContactlistEvent, ContactlistState> {
  final Box<ContactsDataModel> _contactsBox =
      Hive.box<ContactsDataModel>(HiveTagNames.Contacts_Hive_Tag);

  ContactlistBloc() : super(ContactlistInitial()) {
    on<ContactlistLoadInitial>(_onLoadInitial);
    on<ContactlistSearch>(_onSearch);
    on<ContactlistClearSearch>(_onClearSearch);
  }

  Future<void> _onLoadInitial(
    ContactlistLoadInitial event,
    Emitter<ContactlistState> emit,
  ) async {
    try {
      // Load all contacts from Hive
      final contacts = _contactsBox.values.toList();
      emit(ContactlistSuccess(contacts: contacts, searchQuery: ''));
    } catch (e) {
      emit(ContactlistError(message: e.toString(), searchQuery: ''));
    }
  }

  Future<void> _onSearch(
    ContactlistSearch event,
    Emitter<ContactlistState> emit,
  ) async {
    emit(ContactlistLoading(searchQuery: event.searchQuery));

    try {
      // Search contacts in Hive
      final contacts = _contactsBox.values.where((contact) {
        final query = event.searchQuery.toLowerCase();
        final name = contact.ContactName?.toLowerCase() ?? '';
        final phone = contact.PhoneNumber?.toLowerCase() ?? '';
        return name.contains(query) || phone.contains(query);
      }).toList();

      emit(ContactlistSuccess(
          contacts: contacts, searchQuery: event.searchQuery));
    } catch (e) {
      emit(ContactlistError(
          message: e.toString(), searchQuery: event.searchQuery));
    }
  }

  Future<void> _onClearSearch(
    ContactlistClearSearch event,
    Emitter<ContactlistState> emit,
  ) async {
    try {
      // Load all contacts from Hive
      final contacts = _contactsBox.values.toList();
      emit(ContactlistSuccess(contacts: contacts, searchQuery: ''));
    } catch (e) {
      emit(ContactlistError(message: e.toString(), searchQuery: ''));
    }
  }
}
