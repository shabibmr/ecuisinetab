part of 'contacts_editor_bloc.dart';

abstract class ContactsEditorEvent extends Equatable {
  const ContactsEditorEvent();

  @override
  List<Object> get props => [];
}

class FetchContactByPhone extends ContactsEditorEvent {
  const FetchContactByPhone(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

class FetchContactById extends ContactsEditorEvent {
  const FetchContactById(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

class SetContact extends ContactsEditorEvent {
  const SetContact({required this.contact});

  final ContactsDataModel contact;

  @override
  List<Object> get props => [contact];
}

class SetEmptyContact extends ContactsEditorEvent {
  const SetEmptyContact();
}

class SetContactName extends ContactsEditorEvent {
  const SetContactName(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class SetContactPhone extends ContactsEditorEvent {
  const SetContactPhone(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

class SetContactEmail extends ContactsEditorEvent {
  const SetContactEmail(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class SetContactAddress extends ContactsEditorEvent {
  const SetContactAddress(this.address);

  final String address;

  @override
  List<Object> get props => [address];
}

class SetContactType extends ContactsEditorEvent {
  const SetContactType(this.type);

  final int type;

  @override
  List<Object> get props => [type];
}

class ContactsRequestSave extends ContactsEditorEvent {
  const ContactsRequestSave();
}

class SaveContact extends ContactsEditorEvent {
  const SaveContact();
}
