// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDdp4lX-zahbjMZWkIUrqTFcTP3icnjSxs',
    appId: '1:952808555359:web:c0c52fb6d20a242abeecea',
    messagingSenderId: '952808555359',
    projectId: 'documanager-d37b5',
    authDomain: 'documanager-d37b5.firebaseapp.com',
    databaseURL: 'https://documanager-d37b5-default-rtdb.firebaseio.com',
    storageBucket: 'documanager-d37b5.appspot.com',
    measurementId: 'G-CTLCEMLQ9T',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCC_NUX0KyAKJYQB5gkHW3i30xgEMOc2dA',
    appId: '1:952808555359:android:fcec15ea765746f6beecea',
    messagingSenderId: '952808555359',
    projectId: 'documanager-d37b5',
    databaseURL: 'https://documanager-d37b5-default-rtdb.firebaseio.com',
    storageBucket: 'documanager-d37b5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAGJbrZLR0Q06p3TwXOFKV6BbBmGV5FEBU',
    appId: '1:952808555359:ios:83d7d01594923c4fbeecea',
    messagingSenderId: '952808555359',
    projectId: 'documanager-d37b5',
    databaseURL: 'https://documanager-d37b5-default-rtdb.firebaseio.com',
    storageBucket: 'documanager-d37b5.appspot.com',
    iosClientId: '952808555359-ah9pk297aharknm8bv5f435tlltpa0v4.apps.googleusercontent.com',
    iosBundleId: 'com.example.docsManager',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAGJbrZLR0Q06p3TwXOFKV6BbBmGV5FEBU',
    appId: '1:952808555359:ios:83d7d01594923c4fbeecea',
    messagingSenderId: '952808555359',
    projectId: 'documanager-d37b5',
    databaseURL: 'https://documanager-d37b5-default-rtdb.firebaseio.com',
    storageBucket: 'documanager-d37b5.appspot.com',
    iosClientId: '952808555359-ah9pk297aharknm8bv5f435tlltpa0v4.apps.googleusercontent.com',
    iosBundleId: 'com.example.docsManager',
  );
}
