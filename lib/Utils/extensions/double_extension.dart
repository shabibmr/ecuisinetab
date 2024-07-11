// import 'dart:io';

import 'package:intl/intl.dart';

import '../../Login/constants.dart';
import 'package:universal_io/io.dart';

extension RoundOffExtension on double {
  double get roundToOne {
    int no = toInt();

    double fraction = this - no;
    if (fraction < 0.5) {
      fraction = 0;
    } else {
      fraction = 1;
    }
    return fraction + no;
  }

  String get inCurrency {
    try {
      var format = NumberFormat.simpleCurrency(locale: Platform.localeName);
      print('Format : ${format.format(this)}');
      return format.format(this);
    } catch (e) {
      print('Error : ${e.toString()}');
    }
    return "xxx";
  }

  // String get inCurrency2 {
  //   var format = NumberFormat.simpleCurrency(locale: Platform.localeName);
  //   print('Format : ${format.format(this)}');
  //   return '$currency ${toStringAsFixed(2)}';
  // }

  String get inCurrencySmall {
    try {
      var format = NumberFormat.simpleCurrency(
        locale: Platform.localeName,
        decimalDigits: 0,
      );
      // print('Format : ${format.format(this)}');
      return format.format(this);
    } catch (e) {
      print('Error : ${e.toString()}');
    }
    return '';
  }

  String get clean0s {
    RegExp regex = RegExp(r'([.]*0)(?!.*\d)');

    return toString().replaceAll(regex, '');
  }
}
