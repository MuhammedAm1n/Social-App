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
    apiKey: 'AIzaSyAR2kOjtoy7H_pAdj1Q5DIrXya_in9mQBk',
    appId: '1:306201761413:web:519e54b996f1209b667bec',
    messagingSenderId: '306201761413',
    projectId: 'social-414cc',
    authDomain: 'social-414cc.firebaseapp.com',
    storageBucket: 'social-414cc.appspot.com',
    measurementId: 'G-VVQP66VXDP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC54GgmYr5PzszP9sOveB9OLwfQHVYlHpY',
    appId: '1:306201761413:android:6680b83093eac4f5667bec',
    messagingSenderId: '306201761413',
    projectId: 'social-414cc',
    storageBucket: 'social-414cc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyABlBBUdMrc7Ehcfw3PMh-vXf0Uy747-po',
    appId: '1:306201761413:ios:7cced7a73df3453c667bec',
    messagingSenderId: '306201761413',
    projectId: 'social-414cc',
    storageBucket: 'social-414cc.appspot.com',
    iosBundleId: 'com.example.social',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyABlBBUdMrc7Ehcfw3PMh-vXf0Uy747-po',
    appId: '1:306201761413:ios:4566f51fcbd31732667bec',
    messagingSenderId: '306201761413',
    projectId: 'social-414cc',
    storageBucket: 'social-414cc.appspot.com',
    iosBundleId: 'com.example.social.RunnerTests',
  );
}
