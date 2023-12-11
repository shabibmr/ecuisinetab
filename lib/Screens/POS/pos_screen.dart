import '../../Datamodels/HiveModels/InventoryItems/InvetoryItemDataModel.dart';
import '../../Login/constants.dart';

import '../../Screens/POS/pos_item_groups.dart';
import '../../Screens/POS/pos_items.dart';
import '../../Transactions/blocs/voucher_bloc/voucher_bloc.dart';
import '../../Utils/voucher_types.dart';

import '../../widgets/Search/inventory_item_search.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../Datamodels/Masters/Accounts/LedgerMasterDataModel.dart';
import '../../Datamodels/Transactions/general_voucher_datamodel.dart';
import '../../Transactions/blocs/pos/pos_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PosBloc(),
        ),
        BlocProvider(
          create: (context) => VoucherBloc()
            ..add(
              SetVoucher(
                voucher: GeneralVoucherDataModel(
                  VoucherDate: DateTime.now(),
                  InventoryItems: [],
                  ledgersList: [],
                  voucherNumber: '1',
                  VoucherPrefix: Hive.box(HiveTagNames.Settings_Hive_Tag)
                      .get(Config_Tag_Names.Voucher_Prefix),
                  voucherType: GMVoucherTypes.SalesOrder,
                  ledgerObject: LedgerMasterDataModel(
                    LedgerID: '0x5x23x1',
                  ),
                ),
              ),
            )
            ..add(
              SetTransactionType(transactionType: TransactionType.outward),
            ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('POS')),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var inv = await showSearch(
              context: context,
              delegate: InvItemSearchDelegate(
                Hive.box<InventoryItemHive>(HiveTagNames.Items_Hive_Tag),
              ),
            );
            if (inv != null) {
              print('Selected :L ${inv.Item_Name}');
            }
          },
          child: Icon(Icons.send_rounded),
        ),
        body: getBody(),
      ),
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

  Widget getBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: POSInvGroups(),
        ),
        Expanded(
          flex: 9,
          child: POSInvItemsListByGroup(),
        ),
      ],
    );
  }

  CustomScrollView getB2() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 100,
          stretch: true,
          flexibleSpace: FlexibleSpaceBar(
            background: POSInvGroups(),
            title: Text(
              'POS',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Center(
            child: POSInvItemsListByGroup(),
          ),
        ),

        // SliverList(
        //   delegate: SliverChildBuilderDelegate(
        //     (context, index) {
        //       return Center(
        //         child: POSInvItemsListByGroup(),
        //       );
        //     },
        //     childCount: 1,
        //   ),

        // children: [
        //   Expanded(
        //     flex: 2,
        //     child: POSInvGroups(),
        //   ),
        //   Expanded(
        //     flex: 8,
        //     child: Center(
        //       child: POSInvItemsListByGroup(),
        //     ),
        //   ),
        // ],
        // ),
      ],
    );
  }
}
