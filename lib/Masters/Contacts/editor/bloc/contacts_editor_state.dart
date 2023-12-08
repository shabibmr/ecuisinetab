// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'contacts_editor_bloc.dart';

enum EditorStatus {
  initial,
  loading,
  loaded,
  error,
  confirmSave,
  sending,
  sent,
  senderror,
}

class ContactsEditorState extends Equatable {
  const ContactsEditorState({
    this.contact,
    required this.status,
    this.msg,
  });

  final ContactsDataModel? contact;
  final EditorStatus status;
  final String? msg;

  @override
  List<Object?> get props => [contact, status, msg];

  ContactsEditorState copyWith({
    ContactsDataModel? contact,
    EditorStatus? status,
    String? msg,
  }) {
    return ContactsEditorState(
      contact: contact ?? this.contact,
      status: status ?? this.status,
      msg: msg ?? this.msg,
    );
  }
}
