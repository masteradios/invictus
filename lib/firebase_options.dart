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
    apiKey: 'AIzaSyA1y014xyTjQJEIcivuBju3mQvwWtNOS2o',
    appId: '1:547017677460:web:f3878c8f054d3440dc7281',
    messagingSenderId: '547017677460',
    projectId: 'invictus-e1911',
    authDomain: 'invictus-e1911.firebaseapp.com',
    storageBucket: 'invictus-e1911.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBqU47eEOzw0UTP0HBMsd8xIFQ7KkxDfjY',
    appId: '1:547017677460:android:9b647f4ea3f13921dc7281',
    messagingSenderId: '547017677460',
    projectId: 'invictus-e1911',
    storageBucket: 'invictus-e1911.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD9O6ycoY-HLGcsqLkTKjkaWZQge8uVpPU',
    appId: '1:547017677460:ios:9e33a2c0f5b50427dc7281',
    messagingSenderId: '547017677460',
    projectId: 'invictus-e1911',
    storageBucket: 'invictus-e1911.appspot.com',
    iosBundleId: 'com.example.invictus',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD9O6ycoY-HLGcsqLkTKjkaWZQge8uVpPU',
    appId: '1:547017677460:ios:86bc399c8c27263ddc7281',
    messagingSenderId: '547017677460',
    projectId: 'invictus-e1911',
    storageBucket: 'invictus-e1911.appspot.com',
    iosBundleId: 'com.example.invictus.RunnerTests',
  );
}
