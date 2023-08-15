import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyArtKKz597gif7n238Rhdyq-m92e1JY9rg',
    appId: '1:484830556018:web:4221b9e3a096f6ebb0b7eb',
    messagingSenderId: '484830556018',
    projectId: 'fb-auth-provider-815',
    authDomain: 'fb-auth-provider-815.firebaseapp.com',
    storageBucket: 'fb-auth-provider-815.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDR2gGm79edToPgc_i_OTrKkf8pq4S_L0Y',
    appId: '1:484830556018:android:fc2ecbc8ac11858db0b7eb',
    messagingSenderId: '484830556018',
    projectId: 'fb-auth-provider-815',
    storageBucket: 'fb-auth-provider-815.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAa6yoc-hkx7LfiF3xXtIYm-dBWlleVJ-g',
    appId: '1:484830556018:ios:9cc0c32e13127121b0b7eb',
    messagingSenderId: '484830556018',
    projectId: 'fb-auth-provider-815',
    storageBucket: 'fb-auth-provider-815.appspot.com',
    iosClientId:
        '484830556018-db81ioch16dgg4d0h3gvrnvi69898lcj.apps.googleusercontent.com',
    iosBundleId: 'com.example.fbAuthProvider',
  );
}
