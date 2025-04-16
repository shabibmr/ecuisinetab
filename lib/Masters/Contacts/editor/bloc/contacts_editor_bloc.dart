import '../../../../Datamodels/HiveModels/address_book/contacts_data_model.dart';
import '../../../../Webservices/webservicePHP.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../Login/constants.dart';

part 'contacts_editor_event.dart';
part 'contacts_editor_state.dart';

class ContactsEditorBloc
    extends Bloc<ContactsEditorEvent, ContactsEditorState> {
  ContactsEditorBloc()
      : super(const ContactsEditorState(
          status: EditorStatus.initial,
        )) {
    on<FetchContactByPhone>((event, emit) async {
      emit(state.copyWith(status: EditorStatus.loading));
      Box<ContactsDataModel> box =
          Hive.box<ContactsDataModel>(HiveTagNames.Contacts_Hive_Tag);
      try {
        final ContactsDataModel? contact =
            await WebservicePHPHelper.getContactByNumber(event.phone);
        emit(state.copyWith(
          contact: contact,
          status: EditorStatus.loaded,
        ));
      } catch (e) {
        emit(state.copyWith(
          status: EditorStatus.error,
          msg: e.toString(),
        ));
      }
    });
    on<SetEmptyContact>((event, emit) => emit(state.copyWith(
          contact: ContactsDataModel(
            addressId: const Uuid().v4(),
            LocationDetails: [],
          ),
          status: EditorStatus.loaded,
        )));
    on<ContactsRequestSave>((event, emit) => emit(state.copyWith(
          status: EditorStatus.confirmSave,
        )));
    on<SaveContact>((event, emit) async {
      //Check Model conditions.
      emit(state.copyWith(status: EditorStatus.sending));
      try {
        Box<ContactsDataModel> box =
            Hive.box<ContactsDataModel>(HiveTagNames.Contacts_Hive_Tag);
        box.put(state.contact!.addressId, state.contact!);
        await WebservicePHPHelper.saveContact(state.contact!);

        emit(state.copyWith(
          contact: state.contact,
          status: EditorStatus.sent,
        ));
      } catch (e) {
        emit(state.copyWith(
          status: EditorStatus.error,
          msg: e.toString(),
        ));
      }
    });
    on<SetContact>((event, emit) {
      emit(state.copyWith(
        contact: event.contact,
        status: EditorStatus.loaded,
      ));
      print('Editing : ${event.contact.ContactName}');
    });
    on<SetContactName>((event, emit) => emit(state.copyWith(
          contact: state.contact?.copyWith(
            ContactName: event.name,
          ),
        )));
    on<SetContactPhone>((event, emit) => emit(state.copyWith(
          contact: state.contact?.copyWith(
            PhoneNumber: event.phone,
          ),
        )));
    on<SetContactEmail>((event, emit) => emit(state.copyWith(
          contact: state.contact?.copyWith(
            email: event.email,
          ),
        )));
    on<SetContactAddress>((event, emit) => emit(state.copyWith(
          contact: state.contact?.copyWith(
            address: event.address,
          ),
        )));
    on<SetContactType>((event, emit) => emit(state.copyWith(
          contact: state.contact?.copyWith(
            Type: event.type,
          ),
        )));
  }
}
