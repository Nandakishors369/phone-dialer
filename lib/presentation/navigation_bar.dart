import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:phone_dialer/presentation/contacts_screen.dart';
import 'package:phone_dialer/presentation/home_screen.dart';
import 'package:phone_dialer/presentation/recent_screen.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int currentIndex = 0;
  List<Widget> destinations = const [
    HomeScreen(),
    RecentScreen(),
    ContactScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: destinations[currentIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentIndex,
          destinations: [
            NavigationDestination(icon: const Icon(Icons.home), label: "Home"),
            NavigationDestination(icon: const Icon(Icons.home), label: "Home"),
            NavigationDestination(icon: const Icon(Icons.home), label: "Home")
          ],
          onDestinationSelected: (value) => onIndexChanged(index: value),
        ));
  }

  onIndexChanged({required int index}) {
    setState(() {
      currentIndex = index;
    });
  }
}
