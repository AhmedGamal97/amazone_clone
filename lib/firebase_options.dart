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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDCM2m9rjLi5vBQJNrQ5rA2spZ240nJYHY',
    appId: '1:116076432725:web:f430dc213e55368c6273dc',
    messagingSenderId: '116076432725',
    projectId: 'clone-4c2be',
    authDomain: 'clone-4c2be.firebaseapp.com',
    storageBucket: 'clone-4c2be.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBbgRWyNPVFDF44Yep1beY18dQ_uDWX4i8',
    appId: '1:116076432725:android:960a31eb4bc6dedf6273dc',
    messagingSenderId: '116076432725',
    projectId: 'clone-4c2be',
    storageBucket: 'clone-4c2be.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyClfLpcmBrZeJyoHFoyiAGp6Hl0Q5HqiQo',
    appId: '1:116076432725:ios:00167579ec004c156273dc',
    messagingSenderId: '116076432725',
    projectId: 'clone-4c2be',
    storageBucket: 'clone-4c2be.appspot.com',
    iosClientId: '116076432725-cm5j4ppmsk3le653oks7boo4mt0hfq86.apps.googleusercontent.com',
    iosBundleId: 'com.example.amazonclone',
  );
}
