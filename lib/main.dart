import 'package:flutter/material.dart';
import 'package:mobile_app/screens/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile App',
      debugShowCheckedModeBanner : false,
      theme: ThemeData(
        //primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}