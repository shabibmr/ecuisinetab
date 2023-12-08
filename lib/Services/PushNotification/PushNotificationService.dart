import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Login/constants.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future initialise() async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('Perms : ${settings.toString()}');

    var token = await _fcm.getToken();

    print('Token : $token');
    Box settFire = Hive.box('values');

    settFire.put('FCMToken', token);

    // var _localNotifications = new FlutterLocalNotificationsPlugin();
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
      options: DefaultFirebaseConfig.platformOptions, name: 'AppMsging');
  print('Handling a background message ${message.messageId} ${message.data}');
}

// class DefaultFirebaseConfig {
//   static FirebaseOptions get platformOptions {
//     if (kIsWeb) {
//       // Web
//       return DefaultFirebaseConfig.platformOptions.androidClientId
//     } else if (Platform.isIOS || Platform.isMacOS) {
//       // iOS and MacOS
//       return const FirebaseOptions(
//         apiKey: 'AIzaSyAHAsf51D0A407EklG1bs-5wA7EbyfNFg0',
//         appId: '1:448618578101:ios:0b11ed8263232715ac3efc',
//         messagingSenderId: '448618578101',
//         projectId: 'react-native-firebase-testing',
//         authDomain: 'react-native-firebase-testing.firebaseapp.com',
//         iosBundleId: 'io.flutter.plugins.firebase.messaging',
//         iosClientId:
//             '448618578101-evbjdqq9co9v29pi8jcua8bm7kr4smuu.apps.googleusercontent.com',
//         databaseURL: 'https://react-native-firebase-testing.firebaseio.com',
//       );
//     } else {
//       // Android
//       return const FirebaseOptions(
//         appId: '1:809126656444:android:59bbeed032d9a250b353b9',
//         apiKey: 'AIzaSyCuu4tbv9CwwTudNOweMNstzZHIDBhgJxA',
//         projectId: 'ralgopro-7e2c2',
//         messagingSenderId: '809126656444',
//         // authDomain: 'react-native-firebase-testing.firebaseapp.com',
//         // androidClientId:
//         //     '448618578101-sg12d2qin42cpr00f8b0gehs5s7inm0v.apps.googleusercontent.com',
//       );
//     }
//   }
// }
