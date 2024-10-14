import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return android;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
      apiKey: "AIzaSyDZOEO6BlCYAFrGTQU9wDsZcsJqxIG_kec",
      authDomain: "fir-e1749.firebaseapp.com",
      databaseURL: "https://fir-e1749-default-rtdb.firebaseio.com",
      projectId: "fir-e1749",
      storageBucket: "fir-e1749.appspot.com",
      messagingSenderId: "987242241775",
      appId: "1:987242241775:web:e89b9ba3fc8c871dbb851a",
      measurementId: "G-CF8TW3M69M");
}
