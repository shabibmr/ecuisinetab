import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Transactions/InventoryItem/bloc/inventory_item_detail_bloc.dart';

class ItemDetailPage extends StatefulWidget {
  ItemDetailPage({Key? key}) : super(key: key);

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<InventoryItemDetailBloc, InventoryItemDetailState>(
      listener: (context, state) {},
      child: Builder(builder: (context) {
        final status =
            context.select((InventoryItemDetailBloc bloc) => bloc.state.status);
        if (status == ItemDetailStatus.init) {
          return Container();
        } else {
          print('Body body ');
          return getBody();
        }
      }),
    );
  }

  Widget getBody() {
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(children: [
          Expanded(
            flex: 1,
            child: Container(color: Colors.blue.shade50),
          ),
          Container(
            height: 3,
          ),
          Expanded(
            flex: 1,
            child: Container(color: Colors.yellow.shade50),
          ),
        ]));
  }
}

class ItemQtyWidget extends StatefulWidget {
  ItemQtyWidget({Key? key}) : super(key: key);

  @override
  State<ItemQtyWidget> createState() => _ItemQtyWidgetState();
}

class _ItemQtyWidgetState extends State<ItemQtyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
