import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:bigwheel/secret.dart';
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

getAPI(String label){
  var secrets = Secrets();
  return secrets.secretsMap[label];
}

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
      switch (flavor) {
        case 'dev':
          return dev;
        case 'prod':
          return prod;
        default:
          throw UnsupportedError(
            'DefaultFirebaseOptions have not been configured for $flavor - '
            'you can reconfigure this by running the FlutterFire CLI again.',
          );
      }
      // return kDebugMode ? dev : prod;
       // return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        // return android;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for this platform - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static FirebaseOptions dev = FirebaseOptions(
    apiKey: getAPI('apiKey'),
    authDomain: getAPI('authDomain'),
    projectId: getAPI('projectId'),
    storageBucket: getAPI('storageBucket'),
    messagingSenderId: getAPI('messagingSenderId'),
    appId: getAPI('appId'),
    measurementId: getAPI('measurementId'),
  );

  static FirebaseOptions prod = FirebaseOptions(
    apiKey: getAPI('apiKeyProd'),
    authDomain: getAPI('authDomainProd'),
    projectId: getAPI('projectIdProd'),
    storageBucket: getAPI('storageBucketProd'),
    messagingSenderId: getAPI('messagingSenderIdProd'),
    appId: getAPI('appIdProd'),
    measurementId: getAPI('measurementIdProd'),
  );
}
