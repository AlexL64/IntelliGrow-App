import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intelli_grow/views/login_screen.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Account",
          style: TextStyle(color: Colors.lightGreen, fontSize: 24),
        ),
        backgroundColor: Colors.grey[50],
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            const Text("Account"),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                elevation: 0,
              ),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ));
              },
              child: const Text("Disconnect"),
            ),
          ],
        ),
      ),
    );
  }
}
