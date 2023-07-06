import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intelli_grow/views/connected.dart';
import 'views/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Initialise firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Bloque l'affichage en mode protrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Vérifie si l'utilisteur est connecté
  Widget _checkIfUserLoggedIn() {
    if (FirebaseAuth.instance.currentUser != null) {
      // Si l'utilisateur est connecté, affiche la page d'acceuil
      return const Connected();
    } else {
      // Si l'utilisateur n'est pas connecté, affiche la page de connexion
      return const LoginScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IntelliGrow',
      home: _checkIfUserLoggedIn(),
    );
  }
}
