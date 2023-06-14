import 'package:bigwheel/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// To run the program in dev environment type
/// flutter run -d chrome --dart-define=FLAVOR=dev
/// flutter build web --dart-define=FLAVOR=dev
/// firebase deploy -P dev --only hosting:dev
// fireabase deploy -P site-one --only hosting:app-id-one

void main() async{
  await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Big Wheel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        '/home':(context) => const HomePage(),
        // '/counter':(context) => Counter(),
      },
    );
  }
}
