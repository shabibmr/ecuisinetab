import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecuisinetab/Datamodels/Masters/Inventory/InventoryItemDataModel.dart';
import 'package:ecuisinetab/Screens/POS/pos_cart2.dart';
import 'package:ecuisinetab/Screens/POS/pos_items.dart';
import 'package:ecuisinetab/Screens/POS/pos_table_selector.dart';
import 'package:ecuisinetab/Screens/POS/voucher_editor.dart';
import 'package:ecuisinetab/Screens/POS/widgets/common/gm_progress_indicator.dart';
import 'package:ecuisinetab/Screens/address_book/selector/bloc/contactlist_bloc.dart';
import 'package:ecuisinetab/Services/Sync/bloc/sync_ui_config_bloc.dart';

import '../../Datamodels/HiveModels/InventoryItems/InvetoryItemDataModel.dart';
import '../../Login/constants.dart';

import '../../Screens/POS/pos_item_groups.dart';
import '../../Transactions/InventoryItem/bloc/inventory_item_detail_bloc.dart';
import '../../Transactions/blocs/voucher_bloc/voucher_bloc.dart';

import '../../widgets/Search/inventory_item_search.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../Transactions/blocs/pos/pos_bloc.dart';
import 'contacts_button.dart';
import 'pos_item_detail.dart';

class POSScreen extends StatefulWidget {
  const POSScreen({super.key});

  @override
  State<POSScreen> createState() => _POSScreenState();
}

class _POSScreenState extends State<POSScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Builder(
        builder: (context) {
          final status =
              context.select((VoucherBloc bloc) => bloc.state.status);
          if (status == VoucherEditorStatus.sending) {
            return const GMProgress(
              msg: 'Sending Voucher',
            );
          } else if (status == VoucherEditorStatus.loaded) {
            final status = context.select((PosBloc bloc) => bloc.state.status);
            print("WTF");
            return Builder(
              builder: (contextBx) {
                print('State  RERUN @55');
                if (status == POSStatus.OrderSelected) {
                  return getPOSScreen(context);
                } else {
                  return const PosTableSelector();
                }
              },
            );
          } else if (status == VoucherEditorStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (status == VoucherEditorStatus.fetcherror) {
            return Center(child: Text('$status'));
          } else {
            return Center(child: Text('$status'));
          }
        },
      ),
    );
  }

  Widget getPOSScreen(BuildContext context) {
    print('POS SCreen Build');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Builder(
        builder: (context) {
          int count = context.select((VoucherBloc bloc) =>
              bloc.state.voucher?.InventoryItems?.length ?? 0);
          print('Count Changed');
          return Visibility(
            visible: count > 0,
            child: SizedBox(
              height: 80,
              child: InkWell(
                  onTap: () async {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (contextB) {
                        return MultiBlocProvider(
                          providers: [
                            BlocProvider.value(
                              value: context.read<VoucherBloc>(),
                            ),
                            BlocProvider.value(
                              value: context.read<PosBloc>(),
                            ),
                          ],
                          child: const POSCartPage(),
                        );
                      },
                    ));
                  },
                  child: const VoucherFooter()),
            ),
          );
        },
      ),
      drawer: const GroupsDrawer(),
      appBar: AppBar(
        title: const Text('eCuisineTab'),
        actions: [
          TableButton(),
          Visibility(
            visible: false,
            child: BlocProvider.value(
              value: context.read<VoucherBloc>(),
              child: ContactsButton(),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: FloatingActionButton(
              onPressed: () async {
                await openSearch();
              },
              child: const Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: getBodyClassic(),
    );
  }

  Widget getBodyClassic() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 3,
        ),
        SizedBox(height: 80, child: PosGroupsHorizontal()),
        Expanded(child: POSItemsListWidget()),
      ],
    );
  }

  Future<void> openItemDetailAdd(InventoryItemHive item) async {
    await showDialog<InventoryItemDataModel>(
      context: context,
      builder: (context2) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: context.read<VoucherBloc>(),
            ),
            BlocProvider(
              create: (context) => InventoryItemDetailBloc()
                ..add(
                  SetItem(
                    item: InventoryItemDataModel.fromHive(item)
                        .copyWith(ItemReqUuid: 'X'),
                  ),
                )
                ..add(const SetIndex(index: -1))
                ..add(SetItemQuantity(1)),
            ),
          ],
          child: const POSItemDetailPage(),
        );
      },
    );
  }

  Widget getBodyList() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView(),
    );
  }

  Future<void> openSearch() async {
    var inv = await showSearch(
      context: context,
      delegate: InvItemSearchDelegate(
        Hive.box<InventoryItemHive>(HiveTagNames.Items_Hive_Tag),
        context.read<VoucherBloc>(),
      ),
    );
    if (inv != null) {
      openItemDetailAdd(inv);
    }
  }

  Widget getBody() {
    return InvGroupExpansionPanel();
  }
}

Widget getBody2() {
  Box<InventoryItemHive> itemsBox =
      Hive.box<InventoryItemHive>(HiveTagNames.Items_Hive_Tag);
  return ListView.builder(
      itemCount: itemsBox.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 2, 8, 4),
          child: Card(
            child: ListTile(
              title: Text(itemsBox.getAt(index)?.Item_Name ?? ''),
            ),
          ),
        );
      });
}

class TableButton extends StatelessWidget {
  const TableButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return InkWell(
        onTap: () async {
          context.read<PosBloc>().add(FetchCurrentOrders());
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 100),
                child: Center(
                  child: Builder(
                    builder: (context) {
                      final String ref = context.select((VoucherBloc bloc) =>
                          bloc.state.voucher?.reference ?? '');
                      return Text(
                        ref,
                        style: k18lStyleBold,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class GroupsDrawer extends StatelessWidget {
  const GroupsDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green.shade50,
        width: MediaQuery.of(context).size.width * 2 / 3,
        child: Column(
          children: [
            const Flexible(
              flex: 1,
              child: Card(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                      child: AutoSizeText(
                    'Select Group',
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: POSInvGroups(),
            ),
          ],
        ));
  }
}
