// import '../../Datamodels/HiveModels/address_book/contacts_data_model.dart';
// import '../../Login/constants.dart';
// import '../../Masters/Contacts/editor/bloc/contacts_editor_bloc.dart';
// import '../../Masters/Contacts/editor/contacts_editor_widget.dart';
// import '../../Utils/extensions/string_extension.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// // Create Searchdelegate for ContactsDataModel

// class ContactsIcon extends StatelessWidget {
//   const ContactsIcon({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       icon: Icon(
//         Icons.contact_page,
//       ),
//       onPressed: () => showSearch(
//         context: context,
//         delegate: ContactSearchDelegate(),
//       ),
//     );
//   }
// }

// class ContactSearchDelegate extends SearchDelegate<ContactsDataModel?> {
//   ContactSearchDelegate();

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//       IconButton(
//         icon: Icon(Icons.add),
//         onPressed: () async {
//           await createContact(context);
//         },
//       ),
//     ];
//   }

//   Future createContact(BuildContext context) async {
//     String text = query;
//     print('Text :$text ');
//     String phone = '';

//     if (text.replaceAll(' ', '').isNumeric()) {
//       phone = text;
//       text = '';
//     }
//     ContactsDataModel? contact = await showDialog<ContactsDataModel?>(
//       context: context,
//       builder: (context) => BlocProvider(
//         create: (context) => ContactsEditorBloc()
//           ..add(SetContact(ContactsDataModel(
//             LocationDetails: [],
//             ContactName: text.capitalize(),
//             PhoneNumber: phone,
//           ))),
//         child: ContactsEditorPage(),
//       ),
//     );
//     if (contact != null) close(context, contact);
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return getSuggestionsWidget(context, query);
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return getSuggestionsWidget(context, query);
//   }

//   Widget getSuggestionsWidget(BuildContext context, String query) {
//     final List<ContactsDataModel> suggestionList = getSuggestions(query);
//     if (suggestionList.length == 0)
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             color: Colors.red.shade50,
//             child: Center(
//               child: Text(
//                 'No Contacts Found',
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 20,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       );
//     else
//       return ListView.builder(
//         itemBuilder: (context, index) => ListTile(
//           onTap: () {
//             close(context, suggestionList[index]);
//           },
//           onLongPress: () async {
//             await updateContact(context, suggestionList[index]);
//           },
//           leading: Icon(Icons.person),
//           title: RichText(
//             text: TextSpan(
//               text:
//                   suggestionList[index].ContactName!.substring(0, query.length),
//               style: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//               children: [
//                 TextSpan(
//                   text: suggestionList[index]
//                       .ContactName!
//                       .substring(query.length),
//                   style: TextStyle(
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         itemCount: suggestionList.length,
//       );
//   }

//   List<ContactsDataModel> getSuggestions(String query) {
//     Box<ContactsDataModel> contacts =
//         Hive.box<ContactsDataModel>(HiveTagNames.Contacts_Hive_Tag);
//     List<ContactsDataModel> matches = contacts.values
//         .where((element) =>
//             element.PhoneNumber!.toLowerCase().contains(query.toLowerCase()) ||
//             element.ContactName!.toLowerCase().contains(query.toLowerCase()) ||
//             query.length == 0)
//         .toList();
//     return matches;
//   }

//   Future<void> updateContact(
//       BuildContext context, ContactsDataModel? contact) async {
//     contact = await showDialog<ContactsDataModel?>(
//       context: context,
//       builder: (context) => BlocProvider(
//         create: (context) => ContactsEditorBloc()..add(SetContact(contact!)),
//         child: ContactsEditorPage(),
//       ),
//     );
//     if (contact != null) close(context, contact);
//   }
// }
