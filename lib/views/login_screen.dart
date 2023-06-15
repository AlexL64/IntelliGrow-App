import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:intelli_grow/views/connected.dart';


const users = {
  'test': 'test',
};

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Duration get loginTime => const Duration(milliseconds: 1000);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name.trim())) {
        return 'User not exists';
      }
      if (users[data.name.trim()] != data.password.trim()) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
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
            userType: LoginUserType.name,
            userValidator: (_) => null,
            logo: "lib/assets/images/intelligrow_logo_no_background.png",
            onLogin: _authUser,
            onSignup: _signupUser,
            onSubmitAnimationCompleted: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const Connected(),
              ));
            },
            onRecoverPassword: (_) => null,
            theme: LoginTheme(
              primaryColor: Colors.green,
              accentColor: Colors.greenAccent,
              pageColorLight: Colors.transparent,
              pageColorDark: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}