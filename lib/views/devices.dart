import 'package:flutter/material.dart';
import 'package:intelli_grow/widgets/bottom_navbar.dart';

class Devices extends StatelessWidget {
  const Devices({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Device list'),
        ),
        bottomNavigationBar: NavBar(),
      ),
    );
  }
}
