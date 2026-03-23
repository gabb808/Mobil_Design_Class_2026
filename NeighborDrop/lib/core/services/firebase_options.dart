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
    apiKey: 'AIzaSyDo__YsSd8BKY81J1cJ3yJSE_Kh2_SG1k4',
    appId: '1:525608339342:web:abcdef1234567890',
    messagingSenderId: '525608339342',
    projectId: 'neighbordrop-96b76',
    authDomain: 'neighbordrop-96b76.firebaseapp.com',
    storageBucket: 'neighbordrop-96b76.firebasestorage.app',
    measurementId: 'G-XXXXXXXXXX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDo__YsSd8BKY81J1cJ3yJSE_Kh2_SG1k4',
    appId: '1:525608339342:android:01ab8a83b791c2853406df',
    messagingSenderId: '525608339342',
    projectId: 'neighbordrop-96b76',
    storageBucket: 'neighbordrop-96b76.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDo__YsSd8BKY81J1cJ3yJSE_Kh2_SG1k4',
    appId: '1:525608339342:ios:abcdef1234567890',
    messagingSenderId: '525608339342',
    projectId: 'neighbordrop-96b76',
    storageBucket: 'neighbordrop-96b76.firebasestorage.app',
    iosBundleId: 'com.example.studymate',
  );
}
