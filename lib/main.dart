import 'package:flutter/material.dart';
import 'package:intelli_grow/views/connected.dart';
import 'views/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';''

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget _checkIfUserLoggedIn() {
    if (FirebaseAuth.instance.currentUser != null) {
      return const Connected();
    } else {
      return const LoginScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IntelliGrow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x00568f23)),
        useMaterial3: true,
      ),
      home: _checkIfUserLoggedIn(),
    );
  }
}
