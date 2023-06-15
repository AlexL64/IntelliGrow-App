import 'package:flutter/material.dart';
import 'views/login_screen.dart';
import 'views/devices.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IntelliGrow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x00568f23)),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
