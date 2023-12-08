import '../../Datamodels/HiveModels/UOM/UOMHiveModel.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UOMDropDown extends StatefulWidget {
  UOMDropDown({
    super.key,
    this.uom,
    this.onChanged,
    required this.uomList,
  });

  UOMHiveMOdel? uom;
  final List<UOMHiveMOdel> uomList;
  final ValueChanged<UOMHiveMOdel?>? onChanged;

  @override
  State<UOMDropDown> createState() => _UOMDropDownState();
}

class _UOMDropDownState extends State<UOMDropDown> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print('${Hive.box<UOMHiveMOdel>(Uom_Hive_Tag).values.length}');
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: DropdownButton<UOMHiveMOdel>(
        hint: const Text('Select Units'),
        value: widget.uom,
        // icon: const Icon(Icons.keyboard_arrow_down),
        items: widget.uomList.map((e) {
          return DropdownMenuItem<UOMHiveMOdel>(
              value: e,
              child: Text(
                e.uom_Name ?? '',
                style: Theme.of(context).textTheme.titleLarge,
              ));
        }).toList(),
        onChanged: (value) {
          widget.onChanged!(value);
        },
      ),
    );
  }
}

class UOMSearchDelegate extends SearchDelegate<UOMHiveMOdel> {
  final Box<UOMHiveMOdel> itemGroupsBox;

  UOMSearchDelegate(this.itemGroupsBox);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Container(),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    // Box<InventoryItemHive> itemsBox = Hive.box('items');
    print('Length : ${itemGroupsBox.length}');
    List<UOMHiveMOdel> ledList = query.isEmpty
        ? itemGroupsBox.values.toList()
        : itemGroupsBox.values.where((element) {
            return element.uom_Name!
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
                title: Text(ledList[index].uom_Name!),
                // subtitle: Text('@${ledList[index].Price!.toStringAsFixed(2)}'),
                onTap: (() => close(context, ledList[index])),
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
    print('Length : ${itemGroupsBox.length}');
    List<UOMHiveMOdel> ledList = query.isEmpty
        ? itemGroupsBox.values.toList()
        : itemGroupsBox.values.where((element) {
            return element.uom_Name!
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
                title: Text(ledList[index].uom_Name!),
                onTap: (() => close(context, ledList[index])),
              );
            },
          ),
        ),
      );
    }
  }
}
