import '../../Datamodels/HiveModels/InventoryItems/InvetoryItemDataModel.dart';
import '../../Login/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class InventoryItemSearch extends StatefulWidget {
  const InventoryItemSearch({super.key});

  @override
  State<InventoryItemSearch> createState() => _InventoryItemSearchState();
}

class _InventoryItemSearchState extends State<InventoryItemSearch> {
  late Box<InventoryItemHive> items;

  @override
  void initState() {
    items = Hive.box(HiveTagNames.Items_Hive_Tag);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void showItemSearch() async {
    final item = await showSearch<InventoryItemHive>(
      context: context,
      delegate: InvItemSearchDelegate(items),
    );
    print('Selected Item : ${item!.Item_Name}');
  }
}

class InvItemSearchDelegate extends SearchDelegate<InventoryItemHive> {
  final Box<InventoryItemHive> items;

  InvItemSearchDelegate(this.items);

  void _showSnackBar(BuildContext context, String text) {
    var snackBar = SnackBar(
      content: Text(text),
    );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    // Box<InventoryItemHive> itemsBox = Hive.box('items');
    print('Length : ${items.length}');
    List<InventoryItemHive> ledList = query.isEmpty
        ? items.values.toList()
        : items.values.where((element) {
            return element.Item_Name!
                .toLowerCase()
                .contains(query.replaceAll(RegExp('[^A-Za-z0-9]'), ''));
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
                title: Text(ledList[index].Item_Name!),
                subtitle: Text('@${ledList[index].Price!.toStringAsFixed(2)}'),
                onTap: () {
                  close(context, ledList[index]);
                },
              );
            },
          ),
        ),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Box<InventoryItemHive> itemsBox = Hive.box('items');
    print('Length : ${items.length}');
    List<InventoryItemHive> ledList = query.isEmpty
        ? items.values.toList()
        : items.values.where((element) {
            return element.Item_Name!
                .toLowerCase()
                .contains(query.replaceAll(RegExp('[^A-Za-z0-9]'), ''));
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
                title: Text(ledList[index].Item_Name!),
                subtitle: Text('@${ledList[index].Price!.toStringAsFixed(2)}'),
                onTap: () {
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
