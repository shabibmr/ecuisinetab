part of 'contactlist_bloc.dart';

abstract class ContactlistState extends Equatable {
  const ContactlistState();

  @override
  List<Object> get props => [];
}

class ContactlistInitial extends ContactlistState {}

class ContactlistLoading extends ContactlistState {
  final String searchQuery;

  const ContactlistLoading({required this.searchQuery});

  @override
  List<Object> get props => [searchQuery];
}

class ContactlistSuccess extends ContactlistState {
  final List<ContactsDataModel> contacts;
  final String searchQuery;

  const ContactlistSuccess({
    required this.contacts,
    required this.searchQuery,
  });

  @override
  List<Object> get props => [contacts, searchQuery];
}

class ContactlistError extends ContactlistState {
  final String message;
  final String searchQuery;

  const ContactlistError({
    required this.message,
    required this.searchQuery,
  });

  @override
  List<Object> get props => [message, searchQuery];
}
