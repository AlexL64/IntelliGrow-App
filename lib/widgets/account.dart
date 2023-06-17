import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intelli_grow/views/login_screen.dart';
import 'package:intelli_grow/widgets/custom_text_from_field.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool changePasswordDisplayed = false;

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

  String getEmail() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return currentUser.email.toString();
    }
    return "Unknown";
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
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email : ${getEmail()}'),
                if (changePasswordDisplayed)
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('Old password :'),
                        const CustomTextFormField(),
                        const Text('New password :'),
                        const CustomTextFormField(),
                        const Text('Confirm new password :'),
                        const CustomTextFormField(),
                        Stack(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                elevation: 3,
                              ),
                              onPressed: () {
                                changePasswordDisplayed = false;
                                setState(() {});
                              },
                              child: const Text("Cancel"),
                            ),
                            Positioned(
                              right: 0,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  elevation: 3,
                                ),
                                onPressed: () {
                                  changePasswordDisplayed = false;
                                  setState(() {});
                                },
                                child: const Text("Confirm"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                if (!changePasswordDisplayed)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      elevation: 3,
                    ),
                    onPressed: () {
                      changePasswordDisplayed = true;
                      setState(() {});
                    },
                    child: const Text("Change password"),
                  ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  elevation: 3,
                ),
                onPressed: () {
                  showAlertDialog(context);
                },
                child: const Text("Logout"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
