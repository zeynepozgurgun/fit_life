// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyAARqFf-XM6xOawIMTB0QBDC5Wei3IFBgQ',
    appId: '1:111883420642:web:0fd98eb9798b4b0938afbb',
    messagingSenderId: '111883420642',
    projectId: 'fitlife-4a351',
    authDomain: 'fitlife-4a351.firebaseapp.com',
    storageBucket: 'fitlife-4a351.appspot.com',
    measurementId: 'G-B9580VR13G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAZ77eI1gQnXMN4jiCePug8s1f4bgRPAiM',
    appId: '1:111883420642:android:f894af2c5d71f90e38afbb',
    messagingSenderId: '111883420642',
    projectId: 'fitlife-4a351',
    storageBucket: 'fitlife-4a351.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAoztHV-fO3p_37znhdstZWfTVXSYJRqBQ',
    appId: '1:111883420642:ios:8ad8359e7be09f4638afbb',
    messagingSenderId: '111883420642',
    projectId: 'fitlife-4a351',
    storageBucket: 'fitlife-4a351.appspot.com',
    iosBundleId: 'com.example.fitLife',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAoztHV-fO3p_37znhdstZWfTVXSYJRqBQ',
    appId: '1:111883420642:ios:8ad8359e7be09f4638afbb',
    messagingSenderId: '111883420642',
    projectId: 'fitlife-4a351',
    storageBucket: 'fitlife-4a351.appspot.com',
    iosBundleId: 'com.example.fitLife',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAARqFf-XM6xOawIMTB0QBDC5Wei3IFBgQ',
    appId: '1:111883420642:web:545f56cb3ed58d8e38afbb',
    messagingSenderId: '111883420642',
    projectId: 'fitlife-4a351',
    authDomain: 'fitlife-4a351.firebaseapp.com',
    storageBucket: 'fitlife-4a351.appspot.com',
    measurementId: 'G-J5F0G36G16',
  );

}