// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'contacts_bloc.dart';

enum ListBlocStatus {
  initital,
  fetching,
  ready,
  error,
}

enum EditorStatus {
  initial,
  loading,
  loaded,
  error,
  sending,
  sent,
  senderror,
}

class ContactsState extends Equatable {
  const ContactsState({
    required this.status,
    required this.contacts,
  });

  final List contacts;
  final ListBlocStatus status;

  @override
  List<Object?> get props => [
        contacts,
        status,
      ];

  ContactsState copyWith({
    List? contacts,
    ListBlocStatus? status,
  }) {
    return ContactsState(
      contacts: contacts ?? this.contacts,
      status: status ?? this.status,
    );
  }
}
