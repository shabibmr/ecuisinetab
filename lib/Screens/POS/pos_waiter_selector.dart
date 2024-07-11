import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../Transactions/blocs/voucher_bloc/voucher_bloc.dart';

import '../../Datamodels/HiveModels/Employee/EmployeeHiveModel.dart';
import '../../Login/constants.dart';

class WaiterSelectorDialog extends StatelessWidget {
  const WaiterSelectorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Center(
          child: Text(
            'Select Waiter',
            style: TextStyle(fontSize: 22),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10),
            // color: Colors.red,
            child: WaiterGrid(),
          ),
        )
      ],
    );
  }
}

class WaiterGrid extends StatefulWidget {
  const WaiterGrid({super.key});

  @override
  State<WaiterGrid> createState() => _WaiterGridState();
}

class _WaiterGridState extends State<WaiterGrid> {
  Box<EmployeeHiveModel> empBox = Hive.box(HiveTagNames.Employee_Hive_Tag);
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final List<EmployeeHiveModel> empsList = empBox.values
          .where((element) => element.Show_Employee == true)
          .toList();
      return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisExtent: 80,
          ),
          itemCount: empsList.length,
          itemBuilder: (BuildContext context, int index) {
            String name = empsList[index].Name ?? '';
            name = name.isEmpty ? (empsList[index].UserName ?? '') : name;
            return InkWell(
              onTap: () {
                context.read<VoucherBloc>().add(
                    SetVoucherSalesman(salesmanID: empsList[index].id ?? 0));
                Navigator.pop(context);
              },
              child: Card(
                child: Center(
                  child: FittedBox(
                    child: Text(empsList[index].Name ?? ''),
                  ),
                ),
              ),
            );
          });
    });
  }
}
