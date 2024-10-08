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
    apiKey: 'AIzaSyAR7fdYE2OUNRMl4tsLp_-5vkrIZzKTuLU',
    appId: '1:41343714451:web:c00e048a0c6fba1af0b966',
    messagingSenderId: '41343714451',
    projectId: 'wallpaper-app-fecb0',
    authDomain: 'wallpaper-app-fecb0.firebaseapp.com',
    storageBucket: 'wallpaper-app-fecb0.appspot.com',
    measurementId: 'G-8EVXLBY40W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBVxcCrlSkpoXk-fjPUhPwx4Mua2y-Tsxc',
    appId: '1:41343714451:android:f72a399483b987c7f0b966',
    messagingSenderId: '41343714451',
    projectId: 'wallpaper-app-fecb0',
    storageBucket: 'wallpaper-app-fecb0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB_je51meyyOZrj6B_-VzpykDRgO3zC3Bo',
    appId: '1:41343714451:ios:ec55ce090b19be01f0b966',
    messagingSenderId: '41343714451',
    projectId: 'wallpaper-app-fecb0',
    storageBucket: 'wallpaper-app-fecb0.appspot.com',
    iosBundleId: 'com.example.wallpaperApplicationFirebase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB_je51meyyOZrj6B_-VzpykDRgO3zC3Bo',
    appId: '1:41343714451:ios:ec55ce090b19be01f0b966',
    messagingSenderId: '41343714451',
    projectId: 'wallpaper-app-fecb0',
    storageBucket: 'wallpaper-app-fecb0.appspot.com',
    iosBundleId: 'com.example.wallpaperApplicationFirebase',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAR7fdYE2OUNRMl4tsLp_-5vkrIZzKTuLU',
    appId: '1:41343714451:web:a418c8605d16c0aef0b966',
    messagingSenderId: '41343714451',
    projectId: 'wallpaper-app-fecb0',
    authDomain: 'wallpaper-app-fecb0.firebaseapp.com',
    storageBucket: 'wallpaper-app-fecb0.appspot.com',
    measurementId: 'G-LP108CFZHT',
  );

}