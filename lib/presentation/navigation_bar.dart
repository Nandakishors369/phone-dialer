import 'package:flutter/material.dart';
import 'package:phone_dialer/presentation/contacts_screen.dart';
import 'package:phone_dialer/presentation/recent_screen.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int currentIndex = 0;
  List<Widget> destinations = const [RecentScreen(), ContactScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: destinations[currentIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentIndex,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.receipt), label: "Recent"),
            NavigationDestination(icon: Icon(Icons.people), label: "Contacts")
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
