import '../../Datamodels/HiveModels/Ledgers/LedMasterHiveModel.dart';
import '../../Login/constants.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LedgerSearchDelegate extends SearchDelegate<LedgerMasterHiveModel?> {
  final List filters;

  LedgerSearchDelegate({this.filters = const []});
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
          color: Colors.amber, // affects AppBar's background color
          toolbarTextStyle: TextStyle(
              // headline 6 affects the query text
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold)),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Box<LedgerMasterHiveModel> leds = Hive.box(HiveTagNames.Ledgers_Hive_Tag);
    print('Length : ${leds.length}');
    List<LedgerMasterHiveModel> ledList = query.isEmpty
        ? leds.values.toList()
        : leds.values.where((element) {
            return element.Ledger_Name!
                    .toLowerCase()
                    .contains(query.replaceAll(RegExp('[^A-Za-z0-9]'), '')) &&
                (filters.isEmpty || filters.contains(element.Group_Id));
          }).toList();
    if (ledList.isEmpty) {
      return Container(
        color: Colors.red.shade50,
        child: const Center(
          child: Text('No Results'),
        ),
      );
    } else {
      return Container(
        color: Colors.green.shade50,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: ledList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(ledList[index].Ledger_Name!),
              );
            },
          ),
        ),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Box<LedgerMasterHiveModel> leds = Hive.box(HiveTagNames.Ledgers_Hive_Tag);
    print('Length : ${leds.length}');

    late List<LedgerMasterHiveModel> ledList;
    if (query.isEmpty) {
      ledList = leds.values.where((element) {
        // print('${element.Ledger_Name} - ${element.Group_Id}');
        return (filters.isEmpty || filters.contains(element.Group_Id));
      }).toList();
    } else {
      ledList = leds.values.where((element) {
        return element.Ledger_Name!
                .toLowerCase()
                .contains(query.replaceAll(RegExp('[^A-Za-z0-9]'), '')) &&
            (filters.isEmpty || filters.contains(element.Group_Id));
      }).toList();
    }
    // List<LedgerMasterHiveModel> ledList = query.isEmpty
    //     ? leds.values.toList()
    //     : leds.values.where((element) {
    //         return element.Ledger_Name!
    //                 .toLowerCase()
    //                 .contains(query.replaceAll(RegExp('[^A-Za-z0-9]'), '')) &&
    //             (filters != null && filters!.contains(element.Group_Id));
    //       }).toList();
    if (ledList.isEmpty) {
      return Container(
        color: Colors.red.shade50,
        child: const Center(
          child: Text('No Results'),
        ),
      );
    } else {
      return Container(
        color: Colors.green.shade50,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: ledList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(ledList[index].Ledger_Name!),
                onTap: () {
                  // print('id : ${ledList[index]}');
                  close(context, ledList[index]);
                },
              );
            },
          ),
        ),
      );
    }
  }
}
