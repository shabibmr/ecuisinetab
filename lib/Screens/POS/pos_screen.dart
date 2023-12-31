import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecuisinetab/Datamodels/Masters/Inventory/InventoryItemDataModel.dart';
import 'package:ecuisinetab/Screens/POS/pos_cart.dart';
import 'package:ecuisinetab/Screens/POS/pos_table_selector.dart';
import 'package:ecuisinetab/Screens/POS/voucher_editor.dart';
import 'package:ecuisinetab/Services/Sync/bloc/sync_ui_config_bloc.dart';

import '../../Datamodels/HiveModels/InventoryItems/InvetoryItemDataModel.dart';
import '../../Login/constants.dart';

import '../../Screens/POS/pos_item_groups.dart';
import '../../Screens/POS/pos_items.dart';
import '../../Transactions/InventoryItem/bloc/inventory_item_detail_bloc.dart';
import '../../Transactions/blocs/voucher_bloc/voucher_bloc.dart';
import '../../Utils/voucher_types.dart';

import '../../widgets/Search/inventory_item_search.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../Datamodels/Masters/Accounts/LedgerMasterDataModel.dart';
import '../../Datamodels/Transactions/general_voucher_datamodel.dart';
import '../../Transactions/blocs/pos/pos_bloc.dart';
import 'pos_item_detail.dart';

class POSScreen extends StatefulWidget {
  POSScreen({Key? key}) : super(key: key);

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
    return BlocConsumer<SyncServiceBloc, SyncServiceState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state.status == SyncUiConfigStatus.fetched) {
          return Builder(
            builder: (context) {
              final status =
                  context.select((VoucherBloc bloc) => bloc.state.status);
              if (status == VoucherEditorStatus.sending) {
                return Container(
                  child: Text('state : ${state.status} <<<'),
                );
              } else if (status == VoucherEditorStatus.loaded) {
                final status =
                    context.select((PosBloc bloc) => bloc.state.status);
                return Builder(
                  builder: (contextBx) {
                    if (status == POSStatus.OrderSelected) {
                      return getPOSScreen(context);
                    } else {
                      return PosTableSelector();
                    }
                  },
                );
              } else if (status == VoucherEditorStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (status == VoucherEditorStatus.fetcherror) {
                return Center(child: Text('${state.status}'));
              } else {
                return Center(child: Text('${state.status}'));
              }
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget getPOSScreen(BuildContext context) {
    print('POS SCreen Build');
    return Scaffold(
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
                    await showDialog(
                      context: context,
                      builder: (contextB) => Dialog(
                        elevation: 5,
                        child: MultiBlocProvider(
                          providers: [
                            BlocProvider.value(
                              value: context.read<VoucherBloc>(),
                            ),
                            BlocProvider.value(
                              value: context.read<PosBloc>(),
                            ),
                          ],
                          child: POSCartPage(),
                        ),
                      ),
                    );
                  },
                  child: VoucherFooter()),
            ),
          );
        },
      ),
      drawer: GroupsDrawer(),
      appBar: AppBar(
        title: const Text('eCuisineTab'),
        actions: [TableButton()],
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
      body: getBody(),
    );
  }

  Future<void> openItemDetailAdd(InventoryItemHive item) async {
    final InventoryItemDataModel? itemX =
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
          child: Dialog(
            elevation: 3,
            alignment: Alignment.center,
            child: POSItemDetailPage(),
          ),
        );
      },
    );
    if (itemX != null) {
      context.read<VoucherBloc>().add(
            AddInventoryItem(
              inventoryItem: itemX,
            ),
          );
    }
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
      ),
    );
    if (inv != null) {
      openItemDetailAdd(inv);
    }
  }

  Widget getBody() {
    return BlocBuilder<VoucherBloc, VoucherState>(
      builder: (context, state) {
        return InvGroupExpansionPanel();
      },
    );
  }
}

class TableButton extends StatelessWidget {
  TableButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return InkWell(
        onTap: () async {
          context.read<PosBloc>().add(FetchCurrentOrders());

          // await Navigator.of(context).push(MaterialPageRoute(
          //   builder: (contextRoute) => MultiBlocProvider(
          //     providers: [
          //       BlocProvider.value(
          //         value: context.read<PosBloc>()..add(FetchCurrentOrders()),
          //       ),
          //       BlocProvider.value(
          //         value: context.read<VoucherBloc>(),
          //       ),
          //     ],
          //     child: PosTableSelector(),
          //   ),
          // ));
        },
        child: Card(
          child: Container(
            child: Builder(builder: (context) {
              final String ref = context.select(
                  (VoucherBloc bloc) => bloc.state.voucher?.reference ?? '');
              print('Ref : $ref');
              return Text('$ref');
            }),
          ),
        ),
      );
    });
  }
}

class ShowCartButton extends StatelessWidget {
  const ShowCartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Builder(builder: (context) {
          int count = context.select((VoucherBloc bloc) =>
              bloc.state.voucher?.InventoryItems?.length ?? 0);

          return Visibility(
            visible: count > 0,
            child: IconButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (contextB) => Dialog(
                    elevation: 5,
                    child: MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                          value: context.read<VoucherBloc>(),
                        ),
                        BlocProvider.value(
                          value: context.read<PosBloc>(),
                        ),
                      ],
                      child: POSCartPage(),
                    ),
                  ),
                );
              },
              icon: Icon(Icons.send_rounded),
            ),
          );
        }),
      ),
    );
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
