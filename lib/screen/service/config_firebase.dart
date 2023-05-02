import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:firebase_core/firebase_core.dart' show Firebase, FirebaseApp, FirebaseOptions;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class FirebaseService {
  static FirebaseApp? _app;
  static FirebaseApp get app => _app!;

  static FirebaseAuth get firebaseAuth => FirebaseAuth.instanceFor(app: app);
  static FirebaseDatabase get firebaseDatabase => FirebaseDatabase.instanceFor(app: app);
  static FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instanceFor(app: app);

  static Future<void> development() async {
    _app ??= await Firebase.initializeApp(
      name: 'development',
      options: currentPlatform,
    );
  }

  static Future<void> production() async {
    _app ??= await Firebase.initializeApp(
      options: currentPlatform,
    );
  }

  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBw2_Zg169pL27RVf-Na-_w53vzRTYrDmE',
    appId: '1:521131222365:android:7b4b2acb4a525ff766b4b4',
    messagingSenderId: '521131222365',
    projectId: 'asso-e4e43',
    storageBucket: 'asso-e4e43.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAI1qpkVm5DimFEYccq-_F-B5X-4zm1fLY',
    appId: '1:521131222365:ios:20754ff0b9f4e6b866b4b4',
    messagingSenderId: '521131222365',
    projectId: 'asso-e4e43',
    storageBucket: 'asso-e4e43.appspot.com',
    iosClientId: '521131222365-ahjidnpujap7kdcrnj2cde46r25unc71.apps.googleusercontent.com',
    iosBundleId: 'com.asso.asso',
  );
}
