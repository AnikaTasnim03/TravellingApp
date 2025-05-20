import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Login.dart';
import 'Onboarding.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // ✅ Hides the red DEBUG banner
      title: 'TravelLovers',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        useMaterial3: true,
      ),
      home: const OnboardingPage(),
    );
  }
}
