import '../../Login/constants.dart';

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
    return '$currency${toStringAsFixed(2)}';
  }

  String get clean0s {
    RegExp regex = RegExp(r'([.]*0)(?!.*\d)');

    return toString().replaceAll(regex, '');
  }
}
