import 'package:flutter/material.dart';
import 'package:intelli_grow/widgets/account.dart';
import 'package:intelli_grow/widgets/devices.dart';

class Connected extends StatefulWidget {
  const Connected({super.key});

  @override
  State<Connected> createState() => _NavBarState();
}

class _NavBarState extends State<Connected> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Devices(),
    Account(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.bluetooth_rounded),
              label: 'Devices',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.lightGreen,
          onTap: _onItemTapped,
          iconSize: 32,
        ),
      ),
    );
  }
}
