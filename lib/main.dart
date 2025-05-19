import 'package:flutter/material.dart';

import 'Login.dart';
import 'Onboarding.dart';

void main() {
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
