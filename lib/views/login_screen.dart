import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:intelli_grow/views/connected.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Future<String?> _authUser(LoginData data) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: data.name.toString().trim(),
        password: data.password.toString().trim(),
      );
      if (credential.user?.emailVerified == false) {
        await FirebaseAuth.instance.signOut();
        return 'Please verify you email';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return 'Wrong email or password.';
      }
    }
    return null;
  }

  Future<String?> _signupUser(SignupData data) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: data.name.toString().trim(),
        password: data.password.toString().trim(),
      );
      await credential.user?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return e.toString();
    }
    await FirebaseAuth.instance.signOut();
    return "A verification email has been sent.";
  }

  String? _validatePassword(String? password) {
    if (password != null) {
      if (password.isEmpty) {
        return "Password can't be empty";
      }
      if (!password.trim().contains(
          RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$'))) {
        return 'The password must contains at least : 8 characters,\n1 Lower case, 1 Upper case, 1 Number and\n1 Special character.';
      }
    }
    return null;
  }

  Future<String?> _recoverPassword(String name) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: name);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'User not found.';
      }
    } catch (e) {
      return e.toString();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/images/login_background.jpg"),
              fit: BoxFit.cover,
              opacity: 0.8,
            ),
            color: Colors.black,
          ),
          child: FlutterLogin(
            logo: "lib/assets/images/intelligrow_logo_no_background.png",
            onLogin: _authUser,
            onSignup: _signupUser,
            onSubmitAnimationCompleted: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const Connected(),
              ));
            },
            onRecoverPassword: _recoverPassword,
            theme: LoginTheme(
              primaryColor: Colors.green,
              accentColor: Colors.greenAccent,
              pageColorLight: Colors.transparent,
              pageColorDark: Colors.transparent,
            ),
            passwordValidator: _validatePassword,
            messages: LoginMessages(
              recoverPasswordDescription: 'We will send you an email to change your password.',
            ),
          ),
        ),
      ),
    );
  }
}
