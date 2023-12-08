import '/Webservices/webservicePHP.dart';
import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import '../../../../Datamodels/HiveModels/address_book/contacts_data_model.dart';

import 'package:equatable/equatable.dart';

import '../../../../Login/constants.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsListBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsListBloc()
      : super(
          const ContactsState(status: ListBlocStatus.initital, contacts: []),
        ) {
    on<FetchAllContacts>((event, emit) async {
      emit(state.copyWith(status: ListBlocStatus.fetching));
      DateTime last = DateTime(2021);
      final dynamic data =
          await WebservicePHPHelper.getAllContacts(lastUpdated: last);
      if (data == false) {
        emit(state.copyWith(status: ListBlocStatus.error));
        return;
      } else {
        final List allContacts = data["data"] ?? [];
        try {
          Box<ContactsDataModel> box =
              Hive.box<ContactsDataModel>(HiveTagNames.Contacts_Hive_Tag);
          await box.clear();
          allContacts.forEach((element) async {
            // print('${element}');
            try {
              // print('Type ele : ${element.runtimeType}');
              ContactsDataModel item = ContactsDataModel.fromMap(element);
              await box.put(item.addressId, item);
            } catch (e) {
              print('Conv error : ${e.toString()}');
              return;
            }
          });
          print('All contacts Length : ${box.values.length}');
        } catch (e) {
          print('Hive error : ${e.toString()}');
          return;
        }
      }
      emit(state.copyWith(status: ListBlocStatus.ready));
    });

    on<FetchCustomerByPhone>((event, emit) async {
      String number = event.phoneNumber;
      ContactsDataModel? contact =
          await WebservicePHPHelper.getContactByNumber(number);
      print(contact);
      if (contact != null) {
        if (contact.PhoneNumber != null) {
          if (contact.PhoneNumber?.isEmpty == true) {
            contact = contact.copyWith(PhoneNumber: number);
          }
        } else {
          contact = contact.copyWith(PhoneNumber: number);
        }
        print('Contact Set address : ${contact.address}');
      }
    });
  }
}
