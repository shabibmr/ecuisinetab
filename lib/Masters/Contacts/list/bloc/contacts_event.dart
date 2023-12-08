part of 'contacts_bloc.dart';

abstract class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object> get props => [];
}

class FetchAllContacts extends ContactsEvent {}

class FetchCustomerByPhone extends ContactsEvent {
  final String phoneNumber;

  const FetchCustomerByPhone({required this.phoneNumber});
}
