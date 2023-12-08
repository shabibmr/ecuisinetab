import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

const String currency = "";

final currencyFormat = NumberFormat.currency(
  locale: "en_IN",
  symbol: currency,
);

const kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

const kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kDashListStyle = GoogleFonts.roboto(
  color: Colors.black,
  fontSize: 22,
  // fontWeight: FontWeight.bold,
);

final kadminDashListStyle = GoogleFonts.roboto(
  color: Colors.black,
  fontSize: 18,
  // fontWeight: FontWeight.bold,
);

final kTotalListStyle = GoogleFonts.roboto(
  color: Colors.white,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

final kNormalStyle = GoogleFonts.roboto(

    // fontWeight: FontWeight.bold,
    );

const kHeadStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 32,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: const Color(0xFF546e74),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

class SettingsTagNames {
  static String get DBName_Tag => "";

  static String get Company_Name_Tag => "";
  static String get Branch_Name_Tag => "";

  static String get Login_User_Name_tag => "";
  static String get Login_User_Emp_ID => "";

  static String get Base_URL_Tag => "";

  static String get Default_Cash_ID => "";
}

class HiveTagNames {
  static late String dbname;

  static set setDBName(String databaseName) {
    dbname = databaseName;
  }

  static void setDB(String db) {
    dbname = '${db}_';
  }

  static String get Items_Hive_Tag => '${dbname}items';
  static String get ItemGroups_Hive_Tag => '${dbname}item_groups';

  static String get Ledgers_Hive_Tag => '${dbname}ledgers';
  static String get AccountGroups_Hive_Tag => '${dbname}acc_groups';

  static String get Uom_Hive_Tag => '${dbname}uoms';
  static String get PriceLists_Hive_Tag => '${dbname}prices';
  static String get Godowns_Hive_Tag => '${dbname}godowns';

  static String get Employee_Hive_Tag => '${dbname}employees';
  static String get UserGroups_Hive_Tag => '${dbname}user_groups';
  static String get UserPermissions_Hive_Tag => '${dbname}user_perms';

  static String get Contacts_Hive_Tag => '${dbname}contacts';

  static String get UI_Config_Hive_Tag => 'ui_config';

  static String get Settings_Hive_Tag => 'settings';

  static String get Values_Hive_Tag => 'values';
}

class Config_Tag_Names {
  static String get Company_Name_Tag => "CompanyName";
  static String get Branch_Name_Tag => "branch";

  static String get Login_User_Name_tag => "login_user_name";
  static String get Login_User_Emp_ID => "login_user_emp_id";

  static String get Base_URL_Tag => "url";

  static String get Default_Cash_ID => "defaultCash";

  static String get Default_Godown_ID => "defaultGodown";

  static String get Default_PO_Ledger => "defaultPO";

  static String get Default_Bank => "defaultbank";

  static String get Voucher_Prefix => "vPref";
  static String get DBName => "DBName";

  static String get Salesmain_ID => "Salesman_ID";
}

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (kIsWeb) {
      // Web
      return const FirebaseOptions(
          apiKey: "AIzaSyA78eYaMfEeXWI4ni65aDy6s08U9wq5iao",
          authDomain: "algopro-7e2c2.firebaseapp.com",
          projectId: "algopro-7e2c2",
          storageBucket: "algopro-7e2c2.appspot.com",
          messagingSenderId: "809126656444",
          appId: "1:809126656444:web:67b21f619392ae2bb353b9",
          measurementId: "G-5T56W5XE33");
    } else if (Platform.isIOS || Platform.isMacOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        apiKey: 'AIzaSyA78eYaMfEeXWI4ni65aDy6s08U9wq5iao',
        appId: '1:448618578101:ios:0b11ed8263232715ac3efc',
        messagingSenderId: '809126656444',
        projectId: 'football-academy-e9c1d',
        authDomain: 'algopro-7e2c2.firebaseapp.com',
        iosBundleId: 'io.flutter.plugins.firebase.messaging',
        iosClientId:
            '448618578101-evbjdqq9co9v29pi8jcua8bm7kr4smuu.apps.googleusercontent.com',
        databaseURL: 'https://react-native-firebase-testing.firebaseio.com',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:809126656444:android:3f3e6e4020ad1fa1b353b9',
        apiKey: 'AIzaSyA78eYaMfEeXWI4ni65aDy6s08U9wq5iao',
        projectId: 'algopro-7e2c2',
        messagingSenderId: '809126656444',
        authDomain: 'algopro-7e2c2.firebaseapp.com',
        // androidClientId:
        //     '448618578101-sg12d2qin42cpr00f8b0gehs5s7inm0v.apps.googleusercontent.com',
      );
    }
  }
}
