import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:naukri_bloggs/firebase_options.dart'; // Ensure this import is correct
import 'package:naukri_bloggs/screens/home_screen.dart';
import 'package:naukri_bloggs/screens/option_screen.dart';
import 'package:naukri_bloggs/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Use your Firebase options
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      //home: HomeScreen(),
    );
  }
}
