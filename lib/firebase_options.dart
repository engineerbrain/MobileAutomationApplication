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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDRM6OjcrU6btv-UozqAXfD0COsNyrPMa4',
    appId: '1:447224147233:web:48dd7131aafad46fdee260',
    messagingSenderId: '447224147233',
    projectId: 'vizeodevmobil-cb49a',
    authDomain: 'vizeodevmobil-cb49a.firebaseapp.com',
    storageBucket: 'vizeodevmobil-cb49a.appspot.com',
    measurementId: 'G-578J1S5TDR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBcRx7bDuE8I6B92TAkyo-WIW7_-O75kTw',
    appId: '1:447224147233:android:1260e913748d623edee260',
    messagingSenderId: '447224147233',
    projectId: 'vizeodevmobil-cb49a',
    storageBucket: 'vizeodevmobil-cb49a.appspot.com',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBdPn891vfvW5ppiA4a6ijLEzSLLF-UJLU',
    appId: '1:447224147233:ios:b973d37dfd1036c2dee260',
    messagingSenderId: '447224147233',
    projectId: 'vizeodevmobil-cb49a',
    storageBucket: 'vizeodevmobil-cb49a.appspot.com',
    iosBundleId: 'com.vizeodevmobil.vizeodevmobil.RunnerTests',
  );
}
