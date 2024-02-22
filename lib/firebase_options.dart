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
    apiKey: 'AIzaSyCWaJkdMxtlORJXkfkR2iU18nBTHHI1L3Y',
    appId: '1:819035409014:web:434f8ef1ef0c6ed6dced57',
    messagingSenderId: '819035409014',
    projectId: 'wizardry-641e8',
    authDomain: 'wizardry-641e8.firebaseapp.com',
    storageBucket: 'wizardry-641e8.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCwTuD01V4oikEEeZirrg0Gvr90niNuWUY',
    appId: '1:819035409014:android:f3256df59bbcd5aedced57',
    messagingSenderId: '819035409014',
    projectId: 'wizardry-641e8',
    storageBucket: 'wizardry-641e8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC_cKbikL8ZJed4wjY_t-FcF06HYUVWS2g',
    appId: '1:819035409014:ios:08852befdb99d9eadced57',
    messagingSenderId: '819035409014',
    projectId: 'wizardry-641e8',
    storageBucket: 'wizardry-641e8.appspot.com',
    iosBundleId: 'com.example.wizardryApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC_cKbikL8ZJed4wjY_t-FcF06HYUVWS2g',
    appId: '1:819035409014:ios:69fa0ba8f80c6199dced57',
    messagingSenderId: '819035409014',
    projectId: 'wizardry-641e8',
    storageBucket: 'wizardry-641e8.appspot.com',
    iosBundleId: 'com.example.wizardryApp.RunnerTests',
  );
}
