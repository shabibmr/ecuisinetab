import 'package:ecuisinetab/Screens/POS/widgets/Configurations/configurations_bloc.dart';
import 'package:ecuisinetab/widgets/Basic/MStringText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfigurationPage extends StatelessWidget {
  const ConfigurationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConfigurationsBloc()..add(ReadConfig()),
      child: ConfigurationWidget(),
      lazy: false,
    );
  }
}

class ConfigurationWidget extends StatefulWidget {
  ConfigurationWidget({Key? key}) : super(key: key);

  @override
  State<ConfigurationWidget> createState() => _ConfigurationWidgetState();
}

class _ConfigurationWidgetState extends State<ConfigurationWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configure'),
      ),
      body: Builder(builder: (context) {
        final ready =
            context.select((ConfigurationsBloc bloc) => bloc.state.ready);
        if (ready == true) {
          return Column(
            children: [
              Expanded(
                child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        children: [
                          IPAddress(),
                          DBName(),
                          VoucherPrefix(),
                          PrinterName(),
                          ArabicCheck(),
                        ],
                      ),
                    )),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<ConfigurationsBloc>().add(SaveConfiguration());
            Navigator.of(context).pop();
          },
          child: Icon(Icons.save)),
    );

    // ip
    // dbname
    // printername
    // voucher prefix
  }
}

class IPAddress extends StatefulWidget {
  IPAddress({Key? key}) : super(key: key);
  String? ip;

  @override
  State<IPAddress> createState() => _IPAddressState();
}

class _IPAddressState extends State<IPAddress> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final String str = context
          .select((ConfigurationsBloc bloc) => bloc.state.serverIP ?? '');
      print('New IP : $str');
      return MTextField(
        label: 'Base URL',
        controller: TextEditingController()..text = str,
        onChanged: (value) {
          context.read<ConfigurationsBloc>().add(SetIPAddress(str: value));
        },
      );
    });
  }
}

class DBName extends StatefulWidget {
  DBName({Key? key}) : super(key: key);
  String? dbname;
  @override
  State<DBName> createState() => _DBNameState();
}

class _DBNameState extends State<DBName> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final String str =
          context.select((ConfigurationsBloc bloc) => bloc.state.dBName ?? '');
      return MTextField(
        label: 'DBName',
        controller: TextEditingController()..text = str,
        onChanged: (value) {
          context.read<ConfigurationsBloc>().add(SetDbName(str: value));
        },
      );
    });
  }
}

class VoucherPrefix extends StatefulWidget {
  VoucherPrefix({Key? key}) : super(key: key);
  String? vprefix;
  @override
  State<VoucherPrefix> createState() => _VoucherPrefixState();
}

class _VoucherPrefixState extends State<VoucherPrefix> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final String str = context
          .select((ConfigurationsBloc bloc) => bloc.state.voucherPref ?? '');
      return MTextField(
        label: 'Voucher Prefix',
        controller: TextEditingController()..text = str,
        onChanged: (value) {
          context
              .read<ConfigurationsBloc>()
              .add(SetVoucherPrefixConfig(str: value));
        },
      );
    });
  }
}

class PrinterName extends StatefulWidget {
  PrinterName({Key? key}) : super(key: key);
  String? printer;
  @override
  State<PrinterName> createState() => _PrinterNameState();
}

class _PrinterNameState extends State<PrinterName> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final String str = context
          .select((ConfigurationsBloc bloc) => bloc.state.printerName ?? '');
      return MTextField(
        label: 'Bill Printer Name',
        controller: TextEditingController()..text = str,
        onChanged: (value) {
          context.read<ConfigurationsBloc>().add(SetPrinterName(str: value));
        },
      );
    });
  }
}

class ArabicCheck extends StatelessWidget {
  const ArabicCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final bool isArabic = context
          .select((ConfigurationsBloc value) => value.state.arabic ?? false);
      return CheckboxListTile(
        value: isArabic,
        title: Text('Arabic'),
        onChanged: (bool? value) {
          context.read<ConfigurationsBloc>().add(SetArabic(isArabic: value!));
        },
      );
    });
  }
}
