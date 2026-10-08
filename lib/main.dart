import 'package:flutter/material.dart';

void main() {
  runApp(const IslamicCompanionApp());
}

class IslamicCompanionApp extends StatelessWidget {
  const IslamicCompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Islamic Companion',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F5C4D),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('হোম'),
        centerTitle: false,
      ),
      body: const Center(
        child: Text(
          'ইসলামিক কম্প্যানিয়ন',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
