import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    if (Platform.isAndroid) {
      return android;
    }
    if (Platform.isIOS) {
      return ios;
    }
    if (Platform.isMacOS) {
      return macos;
    }
    if (Platform.isWindows) {
      return windows;
    }
    if (Platform.isLinux) {
      return linux;
    }
    throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDemoKeyForAndroidPlaceholder',
    appId: '1:123456789:android:abcdefghijklmnop',
    messagingSenderId: '123456789',
    projectId: 'bankhub-pakistan',
    storageBucket: 'bankhub-pakistan.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDemoKeyForIOSPlaceholder',
    appId: '1:123456789:ios:abcdefghijklmnop',
    messagingSenderId: '123456789',
    projectId: 'bankhub-pakistan',
    storageBucket: 'bankhub-pakistan.appspot.com',
    iosBundleId: 'com.bankhub.pakistan',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDemoKeyForWebPlaceholder',
    appId: '1:123456789:web:abcdefghijklmnop',
    messagingSenderId: '123456789',
    projectId: 'bankhub-pakistan',
    storageBucket: 'bankhub-pakistan.appspot.com',
    authDomain: 'bankhub-pakistan.firebaseapp.com',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDemoKeyForWindowsPlaceholder',
    appId: '1:123456789:windows:abcdefghijklmnop',
    messagingSenderId: '123456789',
    projectId: 'bankhub-pakistan',
    storageBucket: 'bankhub-pakistan.appspot.com',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDemoKeyForMacOSPlaceholder',
    appId: '1:123456789:macos:abcdefghijklmnop',
    messagingSenderId: '123456789',
    projectId: 'bankhub-pakistan',
    storageBucket: 'bankhub-pakistan.appspot.com',
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: 'AIzaSyDemoKeyForLinuxPlaceholder',
    appId: '1:123456789:linux:abcdefghijklmnop',
    messagingSenderId: '123456789',
    projectId: 'bankhub-pakistan',
    storageBucket: 'bankhub-pakistan.appspot.com',
  );
}
