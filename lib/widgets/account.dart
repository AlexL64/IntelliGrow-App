import 'package:flutter/material.dart';

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
      body: const Center(
        child: Column(
          children: [
            Text("Account"),
          ],
        ),
      ),
    );
  }
}
