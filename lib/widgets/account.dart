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

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

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

  Future<void> changePassword() async {
    if (validatePassword()) {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        try {
          final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: currentUser.email.toString(),
            password: oldPasswordController.text.trim(),
          );
          final user = userCredential.user;
          await user?.updatePassword(newPasswordController.text.trim());
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("Password successfully changed"),
            backgroundColor: Colors.green[600],
          ));
          changePasswordDisplayed = false;
          oldPasswordController.text = "";
          newPasswordController.text = "";
          confirmNewPasswordController.text = "";
          setState(() {});
        } on FirebaseAuthException catch (e) {
          if (e.code == 'wrong-password') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Incorrect old password"),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      }
    }
  }

  bool validatePassword() {
    if (oldPasswordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Old password can't be empty."),
        backgroundColor: Colors.red,
      ));
      return false;
    }
    if (newPasswordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("New password can't be empty."),
        backgroundColor: Colors.red,
      ));
      return false;
    }
    if (confirmNewPasswordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Confirm New password can't be empty."),
        backgroundColor: Colors.red,
      ));
      return false;
    }
    if (oldPasswordController.text.trim() == newPasswordController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("New password can't be the same as the old password."),
        backgroundColor: Colors.red,
      ));
      return false;
    }
    if (newPasswordController.text.trim() != confirmNewPasswordController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("New password and Confirm new password are different."),
        backgroundColor: Colors.red,
      ));
      return false;
    }
    if (!newPasswordController.text.trim().contains(
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$'))) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            "The new password must contains at least : 8 characters,\n1 Lower case, 1 Upper case, 1 Number and\n1 Special character."),
        backgroundColor: Colors.red,
      ));
      return false;
    }
    return true;
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
                        CustomTextFormField(
                          label: "Old password",
                          controller: oldPasswordController,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          label: "New password",
                          controller: newPasswordController,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          label: "Confirm new password",
                          controller: confirmNewPasswordController,
                        ),
                        Stack(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                elevation: 3,
                              ),
                              onPressed: () {
                                changePasswordDisplayed = false;
                                oldPasswordController.text = "";
                                newPasswordController.text = "";
                                confirmNewPasswordController.text = "";
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
                                  changePassword();
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
