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
    apiKey: 'AIzaSyCZb4TLAKUxkXfhNZNwUM4awcX7moNcOpE',
    appId: '1:527803327047:web:13ee3d77afa1d046d1c762',
    messagingSenderId: '527803327047',
    projectId: 'fir-todoapps-e58d4',
    authDomain: 'fir-todoapps-e58d4.firebaseapp.com',
    storageBucket: 'fir-todoapps-e58d4.appspot.com',
    measurementId: 'G-5KY0G7LZK9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCFSovOQAyzZawxMw93Cyk_BoP8Zc82bw0',
    appId: '1:527803327047:android:a97ec28b4e357d05d1c762',
    messagingSenderId: '527803327047',
    projectId: 'fir-todoapps-e58d4',
    storageBucket: 'fir-todoapps-e58d4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDvfsHzKKdEt0cV1g7habkx7U0Vvv9utUI',
    appId: '1:527803327047:ios:c6941055a14757cfd1c762',
    messagingSenderId: '527803327047',
    projectId: 'fir-todoapps-e58d4',
    storageBucket: 'fir-todoapps-e58d4.appspot.com',
    iosClientId: '527803327047-n2rp4gcjj3p5jghlfsba3ndl852dek1j.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebasetodoapps',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDvfsHzKKdEt0cV1g7habkx7U0Vvv9utUI',
    appId: '1:527803327047:ios:c6941055a14757cfd1c762',
    messagingSenderId: '527803327047',
    projectId: 'fir-todoapps-e58d4',
    storageBucket: 'fir-todoapps-e58d4.appspot.com',
    iosClientId: '527803327047-n2rp4gcjj3p5jghlfsba3ndl852dek1j.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebasetodoapps',
  );
}