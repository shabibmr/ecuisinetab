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

  @override
  void initState() {
    gBox = Hive.box(HiveTagNames.ItemGroups_Hive_Tag);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PosBloc, PosState>(
      builder: (context, state) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: gBox.length,
          itemBuilder: (listContext, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 40,
                    minHeight: 30,
                    maxWidth: 120,
                  ),
                  child: SizedBox(
                    // height: 25,
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        print('Selected ${gBox.getAt(index)!.Group_ID}');
                        context.read<PosBloc>().add(GroupSelected(
                            groupID: gBox.getAt(index)!.Group_ID!));
                      },
                      child: AutoSizeText(
                        gBox.getAt(index)!.Group_Name!,
                        textAlign: TextAlign.center,
                      ),
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
