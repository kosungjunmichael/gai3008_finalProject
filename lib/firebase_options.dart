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
    apiKey: 'AIzaSyAE8LOTqGIsmcQKphTe1zwA4l_M8lwBsyk',
    appId: '1:622002382674:web:6b9d6d0320aa27dafefc8b',
    messagingSenderId: '622002382674',
    projectId: 'mobile-programming-b719f',
    authDomain: 'mobile-programming-b719f.firebaseapp.com',
    storageBucket: 'mobile-programming-b719f.appspot.com',
    measurementId: 'G-3C8KKY7L92',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC2ActOWtvIFSZ4cpontMw0idn4sB1K8O8',
    appId: '1:622002382674:android:e11cb4a6d9354c33fefc8b',
    messagingSenderId: '622002382674',
    projectId: 'mobile-programming-b719f',
    storageBucket: 'mobile-programming-b719f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCy99Dsb9G8lPHqGtWBDm9qda1TYOrxMXs',
    appId: '1:622002382674:ios:10358ce73d64a95efefc8b',
    messagingSenderId: '622002382674',
    projectId: 'mobile-programming-b719f',
    storageBucket: 'mobile-programming-b719f.appspot.com',
    iosBundleId: 'com.example.ex07',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCy99Dsb9G8lPHqGtWBDm9qda1TYOrxMXs',
    appId: '1:622002382674:ios:02d36d155e0d12dbfefc8b',
    messagingSenderId: '622002382674',
    projectId: 'mobile-programming-b719f',
    storageBucket: 'mobile-programming-b719f.appspot.com',
    iosBundleId: 'com.example.ex07.RunnerTests',
  );
}
