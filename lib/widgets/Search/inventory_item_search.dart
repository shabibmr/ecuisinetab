import 'package:ecuisinetab/Datamodels/HiveModels/PriceList/PriceListEntriesHive.dart';
import 'package:ecuisinetab/Datamodels/Transactions/general_voucher_datamodel.dart';
import 'package:ecuisinetab/Utils/extensions/double_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Datamodels/HiveModels/InventoryItems/InvetoryItemDataModel.dart';
import '../../Login/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Transactions/blocs/voucher_bloc/voucher_bloc.dart';

class InventoryItemSearch extends StatefulWidget {
  const InventoryItemSearch({super.key});

  @override
  State<InventoryItemSearch> createState() => _InventoryItemSearchState();
}

class _InventoryItemSearchState extends State<InventoryItemSearch> {
  late Box<InventoryItemHive> items;
  late Box<PriceListEntriesHive> priceBox;

  @override
  void initState() {
    items = Hive.box(HiveTagNames.Items_Hive_Tag);
    priceBox = Hive.box(HiveTagNames.PriceListsEntries_Hive_Tag);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void showItemSearch() async {
    final item = await showSearch<InventoryItemHive>(
      context: context,
      delegate: InvItemSearchDelegate(items, context.read<VoucherBloc>()),
    );
    print('Selected Item : ${item!.Item_Name}');
  }
}

class InvItemSearchDelegate extends SearchDelegate<InventoryItemHive> {
  final Box<InventoryItemHive> items;
  final VoucherBloc? vBloc;
  InvItemSearchDelegate(this.items, this.vBloc);

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

  bool flag = Hive.box(HiveTagNames.Settings_Hive_Tag)
      .get('isArabic', defaultValue: false);

  @override
  Widget buildResults(BuildContext context) {
    // Box<InventoryItemHive> itemsBox = Hive.box('items');
    print('Length : ${items.length}');
    List<InventoryItemHive> ledList = query.isEmpty
        ? items.values.toList()
        : items.values.where((element) {
            return (element.Item_Name!.toLowerCase().contains(query
                    .toLowerCase()
                    .replaceAll(RegExp('[^A-Za-z0-9]'), '')) ||
                (element.Item_Name_Arabic ?? '~~~~~~~').contains(query));
          }).toList();
    if (ledList.isEmpty) {
      return Container(
        color: Colors.red.shade50,
        child: const Center(
          child: Text('No Results'),
        ),
      );
    } else {
      return BlocBuilder<VoucherBloc, VoucherState>(
        bloc: vBloc,
        builder: (context, state) {
          return Container(
            color: Colors.green.shade50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: ledList.length,
                itemBuilder: (context, index) {
                  int pId = state.voucher?.priceListId ?? 0;
                  InventoryItemHive? item = ledList[index];
                  double price = item.Price ?? 0;
                  if (pId != 0) {
                    price = item.prices?[pId]?.rate ?? 0;
                  }
                  return ListTile(
                    title: Text(item.Item_Name!),
                    subtitle: Text(price.inCurrency),
                    onTap: () {
                      close(context, ledList[index]);
                    },
                  );
                },
              ),
            ),
          );
        },
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
            return element.Item_Name!.toLowerCase().contains(query
                    .toLowerCase()
                    .replaceAll(RegExp('[^A-Za-z0-9]'), '')) ||
                (element.Item_Name_Arabic ?? '~~~~').contains(query);
          }).toList();
    if (ledList.isEmpty) {
      return Container(
        color: Colors.red.shade50,
        child: const Center(
          child: Text('No Results'),
        ),
      );
    } else {
      return BlocBuilder<VoucherBloc, VoucherState>(
        bloc: vBloc,
        builder: (context, state) {
          return Container(
              color: Colors.green.shade50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: ledList.length,
                  itemBuilder: (context, index) {
                    int pId = state.voucher?.priceListId ?? 0;
                    InventoryItemHive? item = ledList[index];
                    double price = item.Price ?? 0;
                    if (pId != 0) {
                      price = item.prices?[pId]?.rate ?? 0;
                    }
                    return ListTile(
                      title: Text(item.Item_Name!),
                      subtitle: Text(price.inCurrency),
                      onTap: () {
                        close(context, ledList[index]);
                      },
                    );
                  },
                ),
              ));
        },
      );
    }
  }
}
