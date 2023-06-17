import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intelli_grow/views/login_screen.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
      style: const ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(Colors.lightGreen),
      ),
      child: const Text("Cancel"),
    );
    Widget continueButton = TextButton(
      onPressed: () async {
        Navigator.of(context, rootNavigator: true).pop('dialog');
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
        await FirebaseAuth.instance.signOut();
      },
      style: const ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(Colors.lightGreen),
      ),
      child: const Text("Continue"),
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Logout ?"),
      content: const Text("Are you sure you want to logout ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

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
              onPressed: () {
                showAlertDialog(context);
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
