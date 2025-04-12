part of 'contactlist_bloc.dart';

abstract class ContactlistEvent extends Equatable {
  const ContactlistEvent();

  @override
  List<Object> get props => [];
}

class ContactlistLoadInitial extends ContactlistEvent {}

class ContactlistSearch extends ContactlistEvent {
  final String searchQuery;

  const ContactlistSearch({required this.searchQuery});

  @override
  List<Object> get props => [searchQuery];
}

class ContactlistClearSearch extends ContactlistEvent {}
