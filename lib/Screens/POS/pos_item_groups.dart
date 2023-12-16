import '../../Datamodels/HiveModels/InventoryGroups/InventorygroupHiveModel.dart';
import '../../Login/constants.dart';
import '../../Transactions/blocs/pos/pos_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class POSInvGroups extends StatefulWidget {
  POSInvGroups({Key? key}) : super(key: key);

  @override
  State<POSInvGroups> createState() => _POSInvGroupsState();
}

class _POSInvGroupsState extends State<POSInvGroups> {
  late Box<InventorygroupHiveModel> gBox;

  final List<InventorygroupHiveModel> _groups = [];

  @override
  void initState() {
    print('init state');
    gBox = Hive.box(HiveTagNames.ItemGroups_Hive_Tag);
    // filter gBox with Group_Type=2 to create _groups;
    for (var item in gBox.values) {
      print('> > > ${item.Group_Name} is ${item.Group_Type}');
      if (item.Group_Type == '2') {
        _groups.add(item);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PosBloc, PosState>(
      builder: (context, state) {
        print('>> len : ${_groups.length}');
        return ListView.builder(
          // scrollDirection: Axis.horizontal,
          itemCount: _groups.length,
          itemBuilder: (listContext, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  print('Selected ${_groups[index].Group_ID}');
                  context
                      .read<PosBloc>()
                      .add(GroupSelected(groupID: _groups[index].Group_ID!));
                  Navigator.of(context).pop();
                },
                child: Card(
                  child: ListTile(
                    title: AutoSizeText(
                      _groups[index].Group_Name!,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
