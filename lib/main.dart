import 'package:flutter/material.dart';
import 'onboarding_page.dart';

void main() {
  runApp(const TravelLoversApp());
}

class TravelLoversApp extends StatelessWidget {
  const TravelLoversApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Lovers',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      home: const OnboardingPage(),
    );
  }
}
