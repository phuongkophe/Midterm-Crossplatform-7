import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crud_app/screens/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAK44mHpznusjMcu2Y2ap6yKlfcy5FYWDo",
            authDomain: "flutter-firebase-app-fa87e.firebaseapp.com",
            projectId: "flutter-firebase-app-fa87e",
            storageBucket: "flutter-firebase-app-fa87e.appspot.com",
            messagingSenderId: "241825787118",
            appId: "1:241825787118:web:47cf8f74973206fadcd7ff"));
  }
  else{
   await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
